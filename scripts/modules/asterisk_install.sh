#!bin/bash
# Installs Asterisk but requires some input from
# the user to choose which packages to install etc.

# Used for printing headers and messages
source ./helpers/print_output.sh

asterisk_install() {
    local version=$1 
    local install_path=$2

    print_header "Installing Asterisk"

    # Run asterisk prerequisites install script
    sudo /${install_path}/asterisk-${version}*/contrib/scripts/install_prereq install && \

    # Configure Asterisk
    cd /${install_path}/asterisk-${version}*/ && \
    sudo ./configure                          && \

    # Menuselect options
    # ------------------------------------------------------------
    # Setup menu options
    # sudo make menuselect       && \  # Run this command instead of the below CLI to get an interactive shell
    
    # The CLI to run instead of interactive menuselect
    echo "Run menuselect"        && \
    menuselect/menuselect           \
    --enable codec_opus             \
    --enable codec_silk             \
    --enable codec_siren7           \
    --enable codec_siren14          \
    --enable codec_g729a            \
    --disable CORE-SOUNDS-EN-GSM    \
    --enable CORE-SOUNDS-EN-WAV     \
    --enable CORE-SOUNDS-EN-G722    \
    --enable EXTRA-SOUNDS-EN-WAV    \
    --enable EXTRA-SOUNDS-EN-G722   \
    menuselect.makeopts          && \

    # ------------------------------------------------------------
    # Build Asterisk
    echo "Run 'make'"                   && \
    sudo make -j12                      && \

    # Install Asterisk 
    echo "Run 'make install'"           && \
    sudo make install                   && \

    # Make basic config files
    echo "Run 'make basic-pbx'"         && \
    sudo make basic-pbx                 && \

    # Optionally install documentation
    # sudo make progdocs -j12 && \

    # Install configs
    echo "Run 'make config and ldconfig'" && \
    sudo make config && sudo ldconfig

    is_error $?
}
