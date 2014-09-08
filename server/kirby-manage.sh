#!/bin/bash
# 
# kirby-manage.sh - v1.0 (08/10/2014)
# Aris Papathéodorou (@_a_r_i_s)
# Fixe file and directory permissions for Kirby
# License : domaine public
#
# Fonctions :
# - Change directory permissions to 775
# - Change File permissions to 664
#
# Todo : better code !
#
# Usage :
# - The script must be copied at the root of user home directory
# - User www-data (or apache) must be in same group as <user>
# - The script file need to be executable. Command: chmod 700 kirby-manage.sh
# - Modify the path to the content/ directory (ex: ./public_html/content/)
# - Run in terminal: ./kirby-manage.sh or add to crontab
#

cd ./path_to_kirby/content/

# Recursively set ALL DIRECTORY permissions
find . -type d -exec chmod 775 {} \+

# Recursively set ALL FILE permissions
find . -type f -exec chmod 664 {} \+

# Maybe useful for somebody
# Recursively set a specific FILE TYPE
# find ./ -name *.pdf -exec chmod 664 {} \;

# Back home
cd ../../