#!/bin/bash
# This script starts the PostgreSQL server and
# creates an 'asterisk' role and an 'asterisk' database.

# Used for printing headers and messages
source ./helpers/print_output.sh

postgresql_setup() {
    print_header "Setup PostgreSQL for Asterisk"

    # Start the server
    sudo service postgresql start

    # Create asterisk role
    sudo -u postgres -H -- psql -d postgres -c "CREATE ROLE asterisk WITH LOGIN CREATEDB PASSWORD 'obelix'"

    # Create asterisk database
    sudo -u postgres -H -- psql -d postgres -c "CREATE DATABASE asterisk WITH OWNER asterisk"

    # Print postgres status
    sudo service --status-all | grep postgresql

    print_done
}