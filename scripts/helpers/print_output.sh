#!/bin/bash
# Print functions for outputting info of what's executing in the script.

# Import terminal colors for formatting
source /workspaces/asterisk-devcontainer/scripts/helpers/colors.sh # Somehow this didn't work with relative path


# Print green 'Done.' text after each command
print_done() {
    printf "\n${Green}Done.${NC}\n\n"
}

# Print the header text for each new section of commands
print_header() {
    echo "-----------------------------------------------------------"
    printf "${BGreen}$1${NC}\n"
    echo "-----------------------------------------------------------"
}

# Print a 'Note' text in yellow
print_note() {
    printf "${Yellow}$1${NC}\n"
}

# Prints the text in red
print_error() {
    printf "${BRed}$1${NC}\n"
}

# Prints green text for 'successfull' messages
print_green() {
    printf "\n${Green}$1${NC}\n"
}
# -----------------------------------------------------#
# EXAMPLE USAGE                                        #
# -----------------------------------------------------#
# print_header "Update packages list and upgrade them" #
# sudo apt update                                      #     
# sudo apt upgrade -y                                  # 
# print_done                                           #     
# -----------------------------------------------------#  