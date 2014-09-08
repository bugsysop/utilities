#!/bin/bash
# 
# kirby-install.sh - v1.0.1 (8/10/2014)
# Aris Papathéodorou (@_a_r_i_s)
# Interactive installation script for Kirby
# License : domaine public
#
# Fonctions :
# - Download from Github the last version of Kirby (v1.*)
# - Create a web directory in /home/<user>/
# - Copy all Kirby files and folders in this directory
# - Configuration of ownership and permissions for files and directories
#
# Todo :
# - Populate site/config/config.php with some default useful values
#
# Perequisits :
# - The script must be copied at the root of user home directory
# - User www-data (or apache) must be in same group as <user>
# - The requested <user> must be a valid user account on your system
#
# Usage :
# - Run in terminal: ./kirby-install.sh
# - Note: The script file need to be executable. 
# - Command: chmod 700 kirby-install.sh
#

echo "Downloading latest Kirby package"
curl -LOk https://github.com/bastianallgeier/kirbycms/archive/master.zip
unzip master.zip
rm -f master.zip
echo "> Done!"

echo " "
echo "Please supply the name of the installation directory (ex.: public_html/ or mysite/)"
read htmlforder
echo " "
echo "Now installing Kirby in $htmlforder/"
mv kirbycms-master/ $htmlforder/
rm -f $htmlforder/.gitignore
echo "> Done!"

echo " "
echo "Please supply the name of an user account (ex.: bobby)"
read username
echo " "
echo "Giving ownership and permissions to $username for files and directories"
chown $username:$username $htmlforder/
chmod 664 $htmlforder/
cd $htmlforder/
find . -exec chown $username:$username {} +
find . -type f -exec chmod 664 {} +
find . -type d -exec chmod 775 {} +
# Not tested :
# chmod 660 site/config/config.php
echo "> Done!"

cd ..

echo " "
echo "All fine! Job completed!"