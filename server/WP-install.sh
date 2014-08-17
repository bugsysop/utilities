#!/bin/bash
# 
# wp-install.sh - v1.0 (17/09/2014)
# Aris Papathéodorou
# Script d’installation de WordPress en français
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
# Le script doit être copié à la racine du répertoire utilisateur
# Vérifier que le fichier est bien exécutable. Sinon : chmod u+x wp-install.sh
# Lancer : ./wp-install.sh
#

echo "Version de WordPress à installer"
read wpversion
echo "Téléchargement de WordPress"
curl -o wordpress.tar.gz http://fr.wordpress.org/wordpress-$wpversion-fr_FR.tar.gz
tar -xvzf wordpress.tar.gz
rm -f wordpress.tar.gz

echo "Répertoire d’installation"
read htmlforder
echo " "
echo "Installation de WordPress"
mv wordpress/ $htmlforder/
cp -p $htmlforder/wp-config-sample.php $htmlforder/wp-config.php

echo "Nom de l’utilisateur (compte)"
read username
echo " "
echo "Finalisation de l’installation"
chown $username:www-data $htmlforder/
chmod 664 $htmlforder/
cd $htmlforder/
find . -exec chown $username:www-data {} +
find . -type f -exec chmod 664 {} +
find . -type d -exec chmod 775 {} +
chmod 660 wp-config.php
cd ..

echo " "
echo "Installation réussie de WordPress $wpversion dans $htmlforder"