#!/usr/bin
# Empresa : Zepto Team Software
# Administrador : Eddy Erazo zamudio 
# Fecha  : 03-06-2016
# Sistema Operativo : Ubuntu 16.05

echo "************* Actualizando Paquetes *******************"
#apt-get update
#apt-get upgrade -y

echo "************** Instalacion de MariaDB ******************"

#apt-get install mariadb-server mariadb-client

echo "-------*---- Configuracion de MariaDB -------*-----------"
#mysql_secure_installation

echo "**************** Instalacion del Servidor Web Apache2 ***********"
#apt-get install apache2 -y
sudo a2enmod rewrite
systemctl restart apache2 
echo "************** Instalacion de PHP 7 *********************"
#apt-get -y install php7.0 libapache2-mod-php7.0
#systemctl restart apache2 
#echo "<?php phpinfo();  ?>" > /var/www/html/info.php
#chown www-data:www-data /var/www/html/info.php

echo "*************** Instalando Paquetes PHP 7 *****************"
#apt-get -y install php7.0-mysql php7.0-curl php7.0-gd php7.0-intl php-pear php-imagick php7.0-imap php7.0-mcrypt php-memcache  php7.0-pspell php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-mbstring php-gettext php7.0-pgsql php7.0-gd php7.0-curl php7.0-zip php-apcu
#systemctl restart apache2 




