#!/bin/bash
# 
# WP-upgrade.sh - v1.1 (17/09/2014)
# Aris Papathéodorou
# Script interactif de mise à jour de WordPress en français
# License : domaine public
#
# Fonctions :
# - Téléchargement de la version indiquée de WordPress en français
# - Sauvegarde des fichiers de configuration et du contenu du site (wp-content)
# - Suppression de la précédente version de WordPress
# - Copie des fichiers de la nouvelle version WordPress dans le répertoire Web
# - Configuration des droits et et de la propriété sur l’ensemble
#
# Todo :
# - None ;-)
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
echo "Sauvegarde des fichiers de configuration et données du site"
cd $htmlforder/
mkdir backup
mv wp-config.php .htaccess backup/
mv wp-content backup/

echo " "
echo "Oh mon Dieu ! Suppression de la version précédente de WordPress"
rm -f wp*.php .htaccess license.txt readme.html xmlrpc.php
rm -rf wp-admin/ wp-includes/

echo " "
echo "Copie des fichiers de la nouvelle version de WordPress"
mv ../wordpress/*.php ../wordpress/*.txt ../wordpress/*.html .
mv ../wordpress/wp-admin/ ../wordpress/wp-includes/ .

echo " "
echo "Restauration des fichiers de configuration et données du site"
mv backup/.htaccess backup/wp-config.php backup/wp-content/ .

echo "Nom du compte utilisateur (ex. : toto)"
read username
echo " "
echo "Finalisation de l’installation"
find . -exec chown $username:www-data {} +
find . -type f -exec chmod 664 {} +
find . -type d -exec chmod 775 {} +

echo " "
echo "Le grand ménage final"
rm -fr backup/
rm -fr ../wordpress/
cd ..

echo " "
echo "La mise à jour en WordPress $wpversion, dans le répertoire $htmlforder/, est terminée"