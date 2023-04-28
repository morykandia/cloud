#!/bin/bash
if [ $# -ne 2 ];then
echo "Erreur, il doit avoir 2 paramètres"
exit 1
fi

if cat /etc/passwd | cut -d\; -f1 | grep $1 > /dev/null;then
echo "utilisateur exist déjà dans le système"
exit 1
fi


#creation utilisateur
useradd -m $1
#generation d'un mot de passe

echo "$1:$1" | sudo chpasswd

#generation du fichier de conf
sed -e "s/MONNOM/$1/" -e "s/NOMDOMAIN/$2/" /etc/nginx/templateSite > /etc/nginx/sites-enabled/$2

#base de données

#créer une base de données
sudo mysql -e "CREATE DATABASE $1;"
sudo mysql -e "CREATE USER '$1'@'localhost' IDENTIFIED BY '$1';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $1.* TO '$1'@'localhost';"
