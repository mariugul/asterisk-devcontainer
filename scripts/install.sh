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
# Version 18 is the latest LTS version.
asterisk_version='18'

install () {
    python_prerequisites
    upgrade_apt_packages
    useradd_asterisk
    postgresql_setup
    asterisk_download ${asterisk_version}
    asterisk_install  ${asterisk_version}
    asterisk_start
}

install