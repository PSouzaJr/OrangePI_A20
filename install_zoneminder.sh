#!/bin/bash

# Atualizando sistema
#apt-get update && apt-get upgrade

# Adiciona o repositório para o Zoneminder
> /etc/apt/sources.list.d/zoneminder.list
echo deb http://http.debian.net/debian jessie-backports mainecho >> /etc/apt/sources.list.d/zoneminder.list

> /etc/apt/preferences.d/zoneminder
echo Package: * >> /etc/apt/preferences.d/zoneminder
echo Pin: origin http.debian.net >> /etc/apt/preferences.d/zoneminder
echo Pin-Priority: 1100 >> /etc/apt/preferences.d/zoneminder

# Atualiza novamente para considerar os repositórios do ZM
apt-get update

gpg --keyserver pgpkeys.mit.edu --recv-key  8B48AD6246925553
gpg -a --export 8B48AD6246925553 | sudo apt-key add -
gpg --keyserver pgpkeys.mit.edu --recv-key  7638D0442B90D010
gpg -a --export 7638D0442B90D010 | sudo apt-key add -

# Atualiza novamente com as chaves corretas
apt-get update

aptitude hold tar

#apt-get upgrade
#apt-get dist-upgrade

# Instala os pacotes necessários para rodar o ZM
apt-get install  php5 mysql-server php-pear php5-mysql

# Instalar zoneminder
apt-get install zoneminder

# Instala os plugins necessários
apt-get install libvlc-dev libvlccore-dev vlc

> ~/.my.cnf
echo [client]  >> ~/.my.cnf
echo user=root >> ~/.my.cnf
echo password=123 >> ~/.my.cnf

# Instala a base do MySQL necessária para funcionar
mysql < /usr/share/zoneminder/db/zm_create.sql 

mysql -e "grant select,insert,update,delete,create on zm.* to 'zmuser'@localhost identified by 'zmpass';"

rm .my.cnf

# Add user to supplementary group:
usermod -aG video www-data

chmod 740 /etc/zm/zm.conf
chown root:www-data /etc/zm/zm.conf

ln -s /etc/zm/apache.conf /etc/apache2/conf-enabled/zoneminder.conf

systemctl enable zoneminder.service

# Link Apache to Zoneminder
# nano /etc/zm/apache.conf

#Check the file to look as below:

#Alias /zm /usr/share/zoneminder
#ScriptAlias /cgi-bin /usr/share/zoneminder/cgi-bin
#<Directory /usr/share/zoneminder>
#php_flag register_globals off
#Options FollowSymLinks
#<IfModule mod_dir.c>
#DirectoryIndex index.php
#</IfModule>
#</Directory>

# MAKE Apache Listen on port 81 temporarily (you can leave this or change it later. I have changed it back to 80 later on in my config):

#nano /etc/apache2/ports.conf

# Link Apache file:

#ln -s /etc/zm/apache.conf /etc/apache2/conf.d/zoneminder.conf

#Restart Daemons

#service apache2 restart
#service zoneminder restart

# Enable CGI and Zoneminder configuration in Apache.
a2enmod cgi
a2enconf zoneminder

# Install Cambozola (needed if you use Internet Explorer)
cd /usr/src && wget http://www.andywilcock.com/code/cambozola/cambozola-latest.tar.gz
tar -xzvf cambozola-latest.tar.gz
replace 936 with cambozola version downloaded
cp cambozola-0.936/dist/cambozola.jar /usr/share/zoneminder


# Trechos retirados do Wiki Zoneminder
# https://wiki.zoneminder.com/Raspbian
# Todos os créditos aos autores

