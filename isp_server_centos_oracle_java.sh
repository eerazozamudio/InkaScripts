#!/bin/bash
# Empresa : Inka Software Peru
# Administrador : Eddy Erazo zamudio 
# Fecha  : 09-08-2016
# Sistema Operativo : Centos 6.7 x86 x64

#yum update
#yum install -y epel-release 
echo " ****************  Servidor actualizado ************************** "
 
echo " ****************  Verificando instalacion de JAVA *************** "

JAVA_VER_MAJOR=""
JAVA_VER_MINOR=""
JAVA_VER_BUILD=""


# Based on: http://stackoverflow.com/a/32026447
for token in $(java -version 2>&1 | grep -i version)
do
    if [[ $token =~ \"([[:digit:]])\.([[:digit:]])\.(.*)\" ]]
    then
        JAVA_VER_MAJOR=${BASH_REMATCH[1]}
        JAVA_VER_MINOR=${BASH_REMATCH[2]}
        JAVA_VER_BUILD=${BASH_REMATCH[3]}

        break
    fi
done

if [[ "$JAVA_VER_MAJOR" = 1 && "$JAVA_VER_MINOR" < 8 ]]; then
	echo " Instalando Java Virtual Machine 1.8 "
	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm"
	sudo yum localinstall jdk-8u60-linux-x64.rpm -y
    rm -Rf jdk-8u60-linux-x64.rpm

    # configurar el JAVA_HOME
    #export JAVA_HOME="/usr/lib/jvm/jre-1.8.60-openjdk.x86_64"

fi


echo "*** Instalar Servidor de Applicaciones para uso de Java ***"
echo -n "*** Que servidor web [tomcat/jboss] :: "
read SERVIDOR_WEB


if [ "$SERVIDOR_WEB" = "tomcat" ]; then
	echo "|***************** Actualizando Paquetes para Tomcat ************************|"
	echo "**** Creando usuario tomcat8 ****"
	useradd -r tomcat8 --shell /bin/false	
	wget http://mirrors.koehn.com/apache/tomcat/tomcat-8/v8.5.4/bin/apache-tomcat-8.5.4.tar.gz -P /tmp
	tar -zxf /tmp/apache-tomcat-8.5.4.tar.gz -C /opt

	ln -s /opt/apache-tomcat-8.5.4 /opt/tomcat-latest
	chown -hR tomcat8: /opt/tomcat-latest /opt/apache-tomcat-8.5.4
	sh  /opt/tomcat-latest/bin/startup.sh
	echo " ************** Apache Toncat esta corriendo en el puerto 8080 ****************"
fi

if [ "$SERVIDOR_WEB" = "jboss"  ]; then
	echo "|****************** Actualizando Paquetes para JBoss ************************|"
	wget http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz -P /var/tmp
	tar -zxf /var/tmp/jboss-as-7.1.1.Final.tar.gz -C /opt
	rm -f /var/tmp/jboss-as-7.1.1.Final.tar.gz
	#useradd -r jboss -d /opt/jboss-as-7.1.1.Final
	chown jboss: -R /opt/jboss-as-7.1.1.Final
	cp /opt/jboss-as-7.1.1.Final/bin/init.d/jboss-as-standalone.sh /etc/init.d/jboss
	chmod +x /etc/init.d/jboss
	mkdir /etc/jboss-as

	echo -e "JBOSS_HOME=/opt/jboss-as-7.1.1.Final \nJBOSS_CONSOLE_LOG=/var/log/jboss-console.log \nJBOSS_USER=jboss" > /etc/jboss-as/jboss-as.conf
    service jboss start
    chkconfig jboss on
fi

