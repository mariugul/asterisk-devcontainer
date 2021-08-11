#!/bin/bash
# Downloads Asterisk from source

# Used for printing headers and messages
source ./helpers/print_output.sh

asterisk_download() {
    # Asterisk version to download
    local version=$1

    # Download Asterisk into /asterisk-download
    cd /                       && \
    mkdir -p asterisk-download && \
    cd asterisk-download       && \
    wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${version}-current.tar.gz && \

    # Untar Asterisk
    sudo tar xvf asterisk-${version}-current.tar.gz && \

    # Download mp3 source
    cd asterisk-${version}*/ && sudo contrib/scripts/get_mp3_source.sh 
}