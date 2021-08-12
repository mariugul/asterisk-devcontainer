#!/bin/bash
# Downloads Asterisk from source

# Used for printing headers and messages
source ./helpers/print_output.sh

asterisk_download() {
    # Asterisk version to download
    local version=$1
    local install_path=$2

    print_header "Downloading Asterisk"

    # Create asterisk-download/ (if not exist) and cd 
    # cd / && mkdir -p asterisk-download && cd asterisk-download     

    cd ${install_path} 

    # Is Asterisk downloaded already?
    FILE=${install_path}/asterisk-${version}-current.tar.gz
    if [ -f "$FILE" ]; then
        print_error "asterisk-${version}-current.tar.gz already downloaded."
        sleep 1
    else 
        # Download Asterisk version: ${version}
        wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${version}-current.tar.gz 
    fi

    # Is Asterisk untared already?
    FILE=/${install_path}/asterisk-${version}.5.1/ # TODO: Make this independent of version number .5.1
    if [ -d "$FILE" ]; then
        print_green "Asterisk already untared, continuing..."
        sleep 1
    else
        echo "Untaring Asterisk..."
        sleep 1
        # Untar Asterisk
        sudo tar -zxvf asterisk-${version}-current.tar.gz 
    fi

    # Download mp3 source
    echo "Downloading mp3 source..."
    cd asterisk-${version}*/ && sudo contrib/scripts/get_mp3_source.sh 
}