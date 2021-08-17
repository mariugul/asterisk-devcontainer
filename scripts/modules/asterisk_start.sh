#!/bin/bash
# Starts the Asterisk service and prints the status.

# Used for printing headers and messages
source ./helpers/print_output.sh

asterisk_start() {
    print_header "Starting Asterisk server as user 'asterisk'"
    
    # Edit Asterisk to run as user and group 'asterisk'
    sed -i 's/#AST_USER/AST_USER/g'   /etc/default/asterisk         && \
    sed -i 's/#AST_GROUP/AST_GROUP/g' /etc/default/asterisk         && \
    sed -i 's/;runuser/runuser/g'     /etc/asterisk/asterisk.conf   && \
    sed -i 's/;rungroup/rungroup/g'   /etc/asterisk/asterisk.conf   && \

    # Start Asterisk and print the service status
    printf "Starting Asterisk..."
    sudo service asterisk restart

    # Check asterisk run status
    if ps ax | grep -v grep | grep "asterisk" > /dev/null
    then
        print_green " [OK]\n"
    else
        error=$?
        print_error " [ERROR]"
        print_error "\nCouldn't start Asterisk"
        print_error "Exit ${error}"
        log_stop_time
        exit 1
    fi
    
    is_error $?
}