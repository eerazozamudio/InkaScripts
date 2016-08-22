#!/bin/bash
# Empresa : Zepto Team Software
# Administrador : Eddy Erazo zamudio 
# Fecha  : 30-05-2016
# Sistema Operativo : Centos 6.7 x86 x64

yum update
yum install -y epel-release 
echo " ****************  Servidor actualizado *********************** "

echo "*** Instalar Servidor Web ***"
echo -n "*** Que servidor web [apache/nginx] "
read SERVIDOR_WEB

echo $SERVIDOR_WEB
if [ "$SERVIDOR_WEB" = "apache" ]; then
	  echo "##### Instalando apache server ####"
	  yum -y install  httpd
 	  chkconfig httpd on
	  service httpd restart
	  echo -n "<?php  phpinfo(); ?>" > /var/www/html/zeptoinfo.php


fi;

if [ "$SERVIDOR_WEB" = "nginx" ]; then

  	  echo" ##### Instalando nginx server ####"
 	  yum -y install  nginx
	  /etc/init.d/nginx start
 	  chkconfig nginx on
	  echo -n "<?php  phpinfo(); ?>" > /usr/share/nginx/www/zeptoinfo.php
fi;

echo "*** Instalando PHP ***"  
yum install -y php hp-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel php-mysql php-pgsql php-fpm php-pdo php-mcrypt


echo -n " Instalar MySQL [S/N] > "
read mysql

if [ "$mysql" = "s" ];then
	echo -n "** Instalando Mysql Server ***"
	yum install -y mysql mysql-server
	service mysqld restart
	chkconfig mysqld on 
fi;
  
  
echo -n " Instalar PostgreSQL [S/N] >"
read pg

if  [ "$pg" = "s" ];then 
	echo -b "** Instalando POSTGRESQL Server ***"
	rpm -Uvh http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
	yum update 
	yum install -y postgresql94-server 
	yum install -y postgresql94-contrib
	service postgresql-9.4 initdb
	service postgresql-9.4 start
	chkconfig postgresql-9.4 on
fi;
  
 
service php-fpm start


IP=$(ip addr show eth0 | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*)
echo  " ****** IP PUBLICA DEL SERVIDOR ******* > $IP" 

