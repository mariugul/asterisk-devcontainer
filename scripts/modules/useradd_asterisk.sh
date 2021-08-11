#!/bin/bash
# This script creates an Asterisk user with the correct priviliges
# and provides a password for the asterisk user, so it can be logged
# into like any other account. The user is prompted to write the 
# password during execution of the script.

# Used for printing headers and messages
source ./helpers/print_output.sh

useradd_asterisk() {
    print_header "Creating Asterisk user with priviliges."

    sudo groupadd asterisk
    sudo useradd -r -d /var/lib/asterisk -g asterisk asterisk
    sudo usermod -aG audio,dialout asterisk
    sudo chown -R asterisk.asterisk /etc/asterisk
    sudo chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk
    sudo chown -R asterisk.asterisk /usr/lib/asterisk

    print_note "Enter password for 'asterisk' user"
    sudo passwd asterisk
    print_done
}