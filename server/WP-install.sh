#!/bin/bash
# 
# wp-install.sh - v1.0 (17/09/2014)
# Aris Papathéodorou
# Script interactif d’installation de WordPress en français
# License : domaine public
#
# Fonctions :
# - Téléchargement de la version indiquée de WordPress en français
# - Création dans /home/<user>/ d’un répertoire Web
# - Copie de WordPress dans ce répertoire
# - Configuration des droits et et de la propriété sur l’ensemble
#
# Todo :
# - Création de la base de donnée
# - Configuration du fichier : wp-config.php
#
# Utilisation :
# Le script doit être copié à la racine du répertoire utilisateur (/home/<user>/)
# Vérifier que le fichier est bien exécutable. Sinon : chmod u+x wp-install.sh
# Lancer : ./wp-install.sh
#
# Attention : 
# - Testé uniquement avec des version 3.9.* de WordPress
# - Si l’on n’est ni sur Ubuntu, ni sur Debian, dans ce cas le groupe d’Apache 
#   n’est pas www-data il faut donc adapter ce script (ex. : RedHat = apache)
# - L'utilisateur doit appartenir au même groupe qu’Apache
#

echo "Version de WordPress à installer (ex. : 3.9.2)"
read wpversion
echo "Téléchargement de WordPress"
curl -o wordpress.tar.gz http://fr.wordpress.org/wordpress-$wpversion-fr_FR.tar.gz
tar -xvzf wordpress.tar.gz
rm -f wordpress.tar.gz

echo "Répertoire d’installation (ex. : public_html ou htdocs)"
read htmlforder
echo " "
echo "Installation de WordPress"
mv wordpress/ $htmlforder/
cp -p $htmlforder/wp-config-sample.php $htmlforder/wp-config.php

echo "Nom du compte utilisateur (ex. : toto)"
read username
echo " "
echo "Finalisation de l’installation"
chown $username:www-data $htmlforder/
chmod 664 $htmlforder/
cd $htmlforder/
find . -exec chown $username:www-data {} +
find . -type f -exec chmod 664 {} +
find . -type d -exec chmod 775 {} +
# Attention : peut ne pas fonctionner avec toutes les configurations serveur dans ce cas, 
# commenter l'instruction ci-dessous, et le fichier wp-config.php restera en 664
chmod 660 wp-config.php
cd ..

echo " "
echo "L’nstallation de WordPress $wpversion, dans $htmlforder/, est terminée"