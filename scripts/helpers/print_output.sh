#!/bin/bash
# Print functions for outputting info of what's executing in the script.

# Import terminal colors for formatting
source /workspaces/asterisk/scripts/helpers/colors.sh


# Print green 'Done.' text after each command
print_done() {
    printf "\n${Green}Done.${NC}\n\n"
}

# Print the header text for each new section of commands
print_header() {
    echo "-----------------------------------------------------------"
    printf "${Green}$1${NC}\n"
    echo "-----------------------------------------------------------"
}

# Print a 'Note' text in yellow
print_note() {
    printf "${Yellow}$1${NC}\n"
}

print_error() {
    printf "${Red}$1${NC}\n"
}

# -----------------------------------------------------#
# EXAMPLE USAGE                                        #
# -----------------------------------------------------#
# print_header "Update packages list and upgrade them" #
# sudo apt update                                      #     
# sudo apt upgrade -y                                  # 
# print_done                                           #     
# -----------------------------------------------------#  