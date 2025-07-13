#!/bin/bash
apt update -y
apt install -y apache2
systemctl start apache2
systemctl enable apache2
mkdir -p /var/www/html/register
echo "<h1>Welcome to Register</h1>" > /var/www/html/register/index.html
sudo ln -s /var/www/html/register/index.html /var/www/html/index.html
