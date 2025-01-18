#!/bin/bash

apt update
apt install wget unzip apache2 -y
systemctl start apache2
systemctl enable apache2
wget https://www.tooplate.com/zip-templates/2108_dashboard.zip
unzip -o 2108_dashboard.zip
cp -r 2108_dashboard/* /var/www/html/
systemctl restart apache2
