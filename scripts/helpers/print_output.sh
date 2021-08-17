#!/bin/bash
# Print functions for outputting info of what's executing in the script.

# Import terminal colors for formatting
source /home/pbx/asterisk-devcontainer/scripts/helpers/colors.sh # Somehow this didn't work with relative path


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
    printf "${Red}$1${NC}\n"
}

# Prints green text for 'successfull' messages
print_green() {
    printf "${Green}$1${NC}\n"
}

# Save the start time/date of script
start_time=`date +%s`

# Log the start time
log_start_time() {
    echo "-----------------------------------------------------------"
    echo "Started at: $(date)"
}

# log finish time
log_stop_time() {
    echo "-----------------------------------------------------------"
    echo "Finished at: $(date)"

    end_time=`date +%s`
    runtime=$((end_time-start_time))
    
    echo "Total run time: ${runtime}s"
}


# Takes the error code of a command and returns 'done' or 'error'.
# An error exits the script
is_error() {
    local status=$1
    
    if test ${status} -eq 0
    then
        print_done
    else
        print_error "ERROR: ${status}"
        log_stop_time
        exit ${status}
    fi
}

# -----------------------------------------------------#
# EXAMPLE USAGE                                        #
# -----------------------------------------------------#
# print_header "Update packages list and upgrade them" #
# sudo apt update                                      #     
# sudo apt upgrade -y                                  # 
# print_done                                           #     
# -----------------------------------------------------#  
