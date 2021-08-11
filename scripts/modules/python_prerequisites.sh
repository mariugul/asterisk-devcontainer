#!/bin/bash
# This script install the python prerequisites by installing
# and setting up a python virtual environment, upgrading pip
# and installing the psycopg2 package needed for Alembic.

# Used for printing headers and messages
source ./helpers/print_output.sh

python_prerequisites() {
    print_header "Installing Python Virtual Environment, pip and psycopg2"

    # Install Python Virtual Env
    sudo apt install -y python3.8-venv  && \
    python3 -m venv tutorial-env        && \
    source tutorial-env/bin/activate    && \

    # Upgrade pip and install psycopg2 for Alembic
    pip install --upgrade pip           && \
    pip install psycopg2-binary

    print_done
}