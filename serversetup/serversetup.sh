#!/bin/bash

# Update package manager
apt update

# Basic server setup
name=$1

echo "Setup for user $name"
adduser $name
usermod -aG sudo $name

apt install ufw -y
apt install openssh-server

ufw allow OpenSSH
ufw enable

# Installing LAMP stack
apt install apache2 -y
apt install mariadb-server -y
apt install php libapache2-mod-php php-mysql -y

ufw allow in "WWW Full"

# Installing phpmyadmin
apt install php-mbstring php-zip php-gd -y

# Commands with user input
mysql_secure_installation
apt install phpmyadmin -y

# Database setup
mariadb < db_setup.sql