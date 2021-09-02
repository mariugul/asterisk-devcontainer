#!/bin/bash
# This script starts the PostgreSQL server and
# creates an 'asterisk' role and an 'asterisk' database.

# Used for printing headers and messages
source ./helpers/print_output.sh

postgresql_setup() {
    print_header "Setup PostgreSQL for Asterisk"

    # Start the server
    printf "Starting PostgreSQL..."
    sudo service postgresql start

    # Check PostgreSQL run status
    if ps ax | grep -v grep | grep "postgresql" > /dev/null
    then
        print_green " [OK]\n"
    else
        error=$?
        print_error " [ERROR]"
        print_error "\nCouldn't start PostgreSQL"
        print_error "Exit ${error}"
        exit 1
    fi

    # Create asterisk role
    echo "SELECT 'CREATE ROLE asterisk WITH LOGIN CREATEDB' WHERE NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'asterisk')\gexec" | sudo -u postgres -- psql -d postgres
    print_green "Created role 'asterisk'\n"
    
    # Set asterisk role password
    sudo -u postgres -H -- psql -d postgres -c "ALTER USER asterisk WITH PASSWORD 'obelix'"
    print_green "\n'asterisk' password was updated"

    # Create asterisk database
    echo "SELECT 'CREATE DATABASE asterisk WITH OWNER asterisk' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'asterisk')\gexec" | sudo -u postgres -- psql -d postgres
    
    # Check for successful creation
    # TODO: Implement a check
    echo "Database 'asterisk':"
    sudo -u postgres -H -- psql -d postgres -c "SELECT FROM pg_database WHERE datname = 'asterisk'"

    # TODO 
    # Populate the database with Alembic
    # 
    # cd /usr/local/src/asterisk-${version}*/contrib/ast-db-manage/
    # sudo cp config.ini.sample config.ini
    # sudo nano config.ini
    #
    # Edit config.ini with the credentials to the database.
    # sqlalchemy.url = postgresql://asterisk:obelix@localhost/asterisk
    #
    # Populate database with tables.
    # alembic -c config.ini upgrade head

    # TODO 
    # Insert all values necesarry for hello-world from sql folder

    # TODO
    # ODBC SETUP. Maybe its own module?
    #
    # Edit /etc/postgresql/12/main/pg_hba.conf to:
    # TYPE  DATABASE USER     CIDR-ADDRESS  METHOD
    # host    all      asterisk 127.0.0.1/32  md5
    # local   all      asterisk               trust
    # host    all      asterisk ::1/128       md5 
    #
    # Verify:
    # echo "select 1" | isql -v asterisk asterisk password
    #
    # Edit /etc/odbcinst.ini
    #
    # Verify:
    # odbcinst -q -d
    # 
    # Configure /etc/odbc.ini
    #
    # Validating:
    # echo "select 1" | isql -v asterisk-connector
    #
    # Recompile Asterisk. This might not be necessary if the 
    # ODBC setup is put somewhere before the installation?
    # $ cd ~/src/asterisk-complete/asterisk/1.8
    # $ ./configure
    # $ make menuselect
    # $ make install
    #
    # Configure /etc/asterisk/res_odbc.conf
    #
    # Start asterisk (different script) and check after starting
    # that you can run "odbc show" from inside the Asterisk CLI and get:
    # ODBC DSN Settings
    # -----------------

    # Name:   asterisk
    # DSN:    asterisk-connector
    #     Number of active connections: 1 (out of 1)
    #     Logging: Disabled


    # Print status of the commands
    is_error $?
}

