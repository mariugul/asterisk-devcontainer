# Realtime Database Configuration
Asterisk can read configuration files from a database. This guide shows how to do that with PostgreSQL in Ubuntu 20.04 LTS.

> Check out this article for setting up realtime postgres with Asterisk: http://www.asteriskdocs.org/en/3rd_Edition/asterisk-book-html-chunk/managing_databases.html
## Install PostgreSQL

```
sudo apt install -y postgresql postgresql-client
```

## Setup Database

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

## ODBC Prerequisites
Install these packages to be able to connect to postgres from Asterisk.
```
sudo apt install -y \
unixodbc            \
unixodbc-dev        \ 
odbc-postgresql     
```

The modules.conf file gives you fine-grained control over what modules Asterisk will
(and will not) load. It’s usually not necessary to explicitly define each module in this
file, but you could if you wanted to. We’re going to create a very simple file like this:
```
[modules]
autoload=yes
preload=res_odbc.so
preload=res_config_odbc.so
```

## Alembic
Alembic is a full database migration tool, with support for upgrading the schemas of existing databases, versioning of schemas, creation of new tables and databases, and a whole lot more. 

Install alembic

```
sudo apt install -y alembic
```

Install pip 
```
sudo apt install -y python3-pip
```

Copy config.ini.sample file to config.ini.

```
cd /asterisk-download/asterisk-18*/contrib/ast-db-manage/
sudo cp config.ini.sample config.ini
sudo nano config.ini
```
Edit config.ini with the credentials to the database.
```INI
sqlalchemy.url = postgresql://asterisk:obelix@localhost/asterisk
```


Populate database with tables.
```
alembic -c config.ini upgrade head
```

## Configure Asterisk
Tell Asterisk how to connect to the database by editing res_odbc.conf with the settings below.

```
sudo nano /etc/asterisk/res_odbc.conf
```
```
[asterisk]
enabled => yes
dsn => asterisk
username => asterisk
password => obelix
pre-connect => yes
```