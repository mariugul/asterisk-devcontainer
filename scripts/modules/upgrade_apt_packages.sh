#!/bin/bash
# This script runs update and upgrade to upate all system packages.

# Used for printing headers and messages
source ./helpers/print_output.sh

upgrade_apt_packages() {
    print_header "Update packages list and upgrade them"
    sudo apt update                                     
    sudo apt upgrade -y                                 
    print_done                                          
}