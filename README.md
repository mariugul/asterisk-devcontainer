# Asterisk 16-18 Devcontainer | Ubuntu 20.04 LTS | PostgreSQL 12

## Prerequisites 
> If you are using a docker container, skip right to the "Install Asterisk" part. 

The prerequisites are installed on container build and defined in the Dockerfile. The "Asterisk install prerequisites" script is run automatically on container start up. If you are going to install Asterisk some other way like on a machine running Ubuntu or in a VM and you want to follow this guide, below are the commands for the apt packages prerequisites. 

```
sudo apt install -y \
software-properties-common \
git \
curl \
wget \
libnewt-dev \
libssl-dev \
libncurses5-dev \
subversion \
libsqlite3-dev \
build-essential \
libjansson-dev \
libxml2-dev \
uuid-dev \
doxygen
```

Run Asterisk install prerequisites script.

```
sudo /asterisk-download/asterisk-18*/contrib/scripts/install_prereq install
```


## Install Asterisk
When the container is built, it runs the "install prerequisites" script and asks to configure your telephone country code. Enter yours and click 'ok'. The terminal should output "install completed successfully" and then you can install Asterisk. Run these commands to configure and install Asterisk.

1. Run the configure file

    ```
    cd /asterisk-download/asterisk-18*/
    sudo ./configure
    ```

2. Setup menu options by running the following command:
    ```bash
    sudo make menuselect
    ```

3. Run make when Asterisk is configured as you wish to build.

    ```bash
    sudo make -j12
    ```

4. Install Asterisk.

    ```bash
    sudo make install
    ```

5. You can optionally install documentation:

    ```bash
    sudo make progdocs -j12
    ```

6.  Finally, install configs.

    ```bash
    sudo make config
    sudo ldconfig
    ```

    When the make config command has completed, it will suggest
    some commands to install the sample configuration files. For the
    purposes of this book (Asterisk The Definitive Guide), you do not want to do this. We will be building the necessary files by hand, so the sample files will only serve to disrupt and confuse that process. Having said that, the sample files are useful, and we will mention them throughout this book, since they are excellent reference material.

    If you want to have the sample files for reference or otherwise, run one of these commands:
    ```
    sudo make samples
    sudo make basic-pbx
    ```
## Create Asterisk User

* Create a separate user and group to run asterisk services, and assign correct permissions:

    ```
    sudo groupadd asterisk
    sudo useradd -r -d /var/lib/asterisk -g asterisk asterisk
    sudo usermod -aG audio,dialout asterisk
    sudo chown -R asterisk.asterisk /etc/asterisk
    sudo chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk
    sudo chown -R asterisk.asterisk /usr/lib/asterisk
    sudo passwd asterisk
    ```

## Setup Database
>This might not work from a container running the user "vscode". As an option, sett the password for the postgres account to "postgres" running `sudo passwd postgres` and then log into the account with `su -l postgres`. From here psql can be executed and the role "vscode" can be added.

Log in to the database as user _postgres_. 

```bash
sudo -u postgres psql
```


Create _asterisk_ role

```PostgreSQL
CREATE ROLE asterisk WITH LOGIN CREATEDB PASSWORD 'obelix'
```

Create _asterisk_ database
```PostgreSQL
CREATE DATABASE asterisk WITH OWNER asterisk
```


## Start Asterisk Service

* Set Asterisk default user to asterisk:

    ```
    sudo nano /etc/default/asterisk
    AST_USER="asterisk"
    AST_GROUP="asterisk"

    sudo nano /etc/asterisk/asterisk.conf
    runuser = asterisk ; The user to run as.
    rungroup = asterisk ; The group to run as. 
    ```

* Restart asterisk service after making the changes:
    
    ```bash
    sudo service asterisk restart
    ```
    or
    ```
    sudo /etc/init.d/asterisk restart
    ```

* Enable asterisk service to start on system  boot:
    
    ```
    sudo systemctl enable asterisk
    ```
* Check service status to see if it is running.
    
    ```bash
    sudo service --status-all | grep asterisk
    ```

* Verify you can connect to Asterisk Command Line interface.

    ```bash
    sudo asterisk -rvvv
    ```

## Firewall Exception 
>This doesn't work on WSL. Skip this step.

Install ufw firewall.
```
sudo apt install ufw
```

Open tcp and udp ports 5060 and 5061.

```
sudo ufw allow proto tcp from any to any port 5060,5061
sudo ufw allow proto udp from any to any port 5060,5061
```

## Make Asterisk Connectable
Connect to Asterisk.
```
sudo asterisk -rvvv
```

Load the sip module.
```
module load chan_sip.so
```

## Helpful Commands
| Description   | Command     |
| ------------- |-------------|
| Desc      | `cmd` |