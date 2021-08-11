#!bin/bash
# Installs Asterisk but requires some input from
# the user to choose which packages to install etc.

# Used for printing headers and messages
source ./helpers/print_output.sh

asterisk_install() {
    local version=$1 

    print_header "Installing Asterisk"

    # Run asterisk prerequisites install script
    sudo /asterisk-download/asterisk-${version}*/contrib/scripts/install_prereq install &&  \

    # Configure Asterisk
    cd /asterisk-download/asterisk-${version}*/ && \
    sudo ./configure                    && \

    # Setup menu options
    sudo make menuselect                && \

    # Build Asterisk
    sudo make -j12                      && \

    # Install Asterisk 
    sudo make install                   && \

    # Make basic config files
    sudo make basic-pbx                 && \

    # Optionally install documentation
    # sudo make progdocs -j12 && \

    # Install configs
    sudo make config && sudo ldconfig

    print_done
}
