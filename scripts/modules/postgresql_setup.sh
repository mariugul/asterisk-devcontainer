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
    echo "Database 'asterisk':"
    sudo -u postgres -H -- psql -d postgres -c "SELECT FROM pg_database WHERE datname = 'asterisk'"

    # Print status of the commands
    is_error $?
}

