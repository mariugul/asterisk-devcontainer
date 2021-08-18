# Asterisk 16-18 Devcontainer | Ubuntu 20.04 | PostgreSQL 12
This repository contains a devcontainer for docker and also the scripts to install Asterisk from source on **Ubuntu 20.04 LTS**. It's made to be set up with **PostgreSQL 12** as a realtime database for Asterisk configuration files, but can be used without this feature, of course. 

The difference between running a docker devcontainer or just installing Asterisk on a Ubuntu in a virtual machine or elsewhere from this repository is very small. The install scripts are the same, it just makes it simpler to have the devcontainer bundled. So the real power of this repository is to automate the installation of Asterisk, set up with realtime PostgreSQL database.

## Devcontainer
For a complete installation description, go to `DEVCONTAINER.MD`

### Quickstart
A docker devcontainer can be used to install and run Asterisk for easy development and testing. To do so, download this git repository and open the repository in vscode. With the docker tools installed you should be prompted to open inside devcontainer. From there some prerequisites will be built on a docker image of Ubuntu 20.04 and then the scripts to install Asterisk will run automatically on startup. Some prompts will show up to ask for certain configuration parameters. You can run the scripts yourself at a later time if you wish to do a different configuration of modules or similar. 

## Ubuntu 20.04
For a complete installation description, go to `UBUNTU.md`.

### Quickstart
Clone the repository and run the scripts by issuing the command:

```
sudo ./install.sh | tee install.log
```
## Install Scripts
The main purpose of this repository revolves around the scripts to install and configure everything. These scripts are found in `/scripts`. This folder contains the folders `helpers` and `modules` as well as the files `install.sh` and `remove.sh`. 

For installation run the `install.sh` script. You can log everything to a log-file in case of any errors. If you want to save a log file, run the script with this command below.

```
sudo ./install.sh | tee install.log
```

`remove.sh`
> Run this script only if you wish to wipe the system entirely of any trace of Asterisk. You will be prompted in the terminal whether you wish to proceed and if you want to remove the database as well.

`/helpers`
>This folder contains the scripts that do color print to the terminal and formatting of the commands. It's merely an aid in seeing how the install script is progressing. The script `print_output.sh` also contains functions to log the time and an error check.

`/modules`
>These bash scripts are the actual installation and configuration of Asterisk, PostgreSQL and any needed prerequisites. Each logical part of installing Asterisk and PostgreSQL on Ubuntu has been divided into its own script for ease of implementation and troubleshooting should something go wrong. Each of these scripts are called from the main install script `install.sh`.

## Asterisk Config Files
TODO: Add info about the `/config` folder.

## Other README Files
There are several markdown files with information in this repository. By default, the intallation and configuration process is handled by the scripts and you should not need to intervene much with this process. However, the process that the scripts implements are documented in the several markdown files.

