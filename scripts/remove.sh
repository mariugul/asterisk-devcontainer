#!/bin/bash
# This script removes the entire Asterisk installation and all it's folders and files.
# Only run this if you wish to reinstall Asterisk from a clean slate.

# Used for printing headers and messages
source ./helpers/print_output.sh

local install_path="/etc/local/src"
local version="18"

# Kill asterisk process
killall -9 safe_asterisk
sudo service asterisk stop
kill $(ps aux | grep '[a]sterisk' | awk '{print $2}') # Finds process ID and kills asterisk

# Make sure Asterisk is killed
sleep 1
ps aux | grep asterisk

# Ask user for confirmation. Anything other than 'y' will terminate.
print_note "\nAre you sure you want to remove Asterisk and all its files? [y/n] "
read -r -p "" response
if [[ "$response" != 'y' ]]
then
    print_error "Exiting..."
    exit 1
fi

print_note "Removing asterisk..."

# Remove Asterisk files
sudo rm -rf /etc/asterisk
sudo rm -rf /var/log/asterisk
sudo rm -rf /var/lib/asterisk
sudo rm -rf /var/spool/asterisk
sudo rm -rf /usr/lib/asterisk

# Remove the asterisk tarball and untared folder
sudo rm -rf ${install_path}/asterisk-${version}-current.tar.gz
sudo rm -rf ${install_path}/asterisk-${version}.5.1/

print_done
