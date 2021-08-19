#!/bin/bash 
# This script runs when the container image has been built.  
# Prerequisites and certain packages are installed.          

# Let script exit if a command fails. 
# set -o errexit

# Import install scripts
source modules/python_prerequisites.sh
source modules/upgrade_apt_packages.sh
source modules/useradd_asterisk.sh
source modules/postgresql_setup.sh
source modules/asterisk_install.sh
source modules/asterisk_start.sh
source modules/asterisk_download.sh

# Choose which Asterisk version to install between 16 and 18. 
# Version 18 is the latest LTS version as of the year 2021.
asterisk_version='18'

# Path to where Asterisk will be installed.
install_path="/usr/local/src"

install() {
    log_start_time
    upgrade_apt_packages
    python_prerequisites
    asterisk_download ${asterisk_version} ${install_path}
    asterisk_install  ${asterisk_version} ${install_path}
    useradd_asterisk
    postgresql_setup
    asterisk_start
    log_stop_time
}

install