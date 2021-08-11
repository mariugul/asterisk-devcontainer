#!/bin/bash
# Starts the Asterisk service and prints the status.

# Used for printing headers and messages
source ./helpers/print_output.sh

asterisk_start() {
    print_header "Starting Asterisk server as user 'asterisk'"
    
    # Edit Asterisk to run as user and group 'asterisk'
    sed -i 's/#AST_USER/AST_USER/g'   /etc/default/asterisk
    sed -i 's/#AST_GROUP/AST_GROUP/g' /etc/default/asterisk
    sed -i 's/;runuser/runuser/g'     /etc/asterisk/asterisk.conf
    sed -i 's/;rungroup/rungroup/g'   /etc/asterisk/asterisk.conf

    # Start Asterisk and print the service status
    sudo service asterisk start
    sudo service --status-all | grep asterisk
    print_done
}