#!/bin/bash
# Empresa : Zepto Team Software
# Administrador : Eddy Erazo zamudio 
# Fecha  : 03-05-2016
# Sistema Operativo : Ubuntu 15.10  

#sudo apt-get update 
#sudo apt-get upgrade
echo "---------------- Servidor actualizado ------------------------"

host=$(hostname)
echo  "# Nombre del host local :  $host"
echo  "# Instalando el bzip2   "
#sudo apt-get install -y bzip2
#sudo apt-get install -y wget 
echo  "# Creando espacio temporal"
#sudo mkdir /opt/iredmail
#sudo chmod 755 /opt/iredmail
wget https://bitbucket.org/zhb/iredmail/downloads/iRedMail-0.9.5.tar.bz2
sudo cp iRedMail-0.9.5.tar.bz2 /opt/iredmail
sudo rm -f iRedMail-0.9.5.tar.bz2
tar jxvf /opt/iredmail/iRedMail-0.9.5.tar.bz2
sudo mv iRedMail-0.9.5 /opt/iredmail
sudo bash  /opt/iredmail/iRedMail-0.9.5/iRedMail.sh
