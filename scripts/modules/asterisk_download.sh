#!/bin/bash
# Downloads Asterisk from source

# Used for printing headers and messages
source ./helpers/print_output.sh

asterisk_download() {
    # Asterisk version to download
    local version=$1
    local install_path=$2

    print_header "Downloading Asterisk"

    cd ${install_path} 

    # Is Asterisk downloaded already?
    asterisk_download=${install_path}/asterisk-${version}-current.tar.gz
    if [ -f "$asterisk_download" ]; then
        print_error "asterisk-${version}-current.tar.gz already downloaded."
        sleep 1
    else 
        # Download Asterisk version: ${version}
        wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${version}-current.tar.gz 
    fi

    # Look for untared folder
    untared_folder=$(find ./ -maxdepth 1 -type d -name "asterisk*") 

    # Is Asterisk untared already?
    if [ -z "$untared_folder" ]
    then
        echo "Untaring Asterisk..."
        sleep 1
        # Untar Asterisk
        sudo tar -zxvf asterisk-${version}-current.tar.gz 
    else
        print_green "Asterisk already untared, continuing...\n"
        sleep 1
    fi

    # Download mp3 source
    echo "Downloading mp3 source..."
    cd asterisk-${version}*/ && sudo contrib/scripts/get_mp3_source.sh 

    print_done
}