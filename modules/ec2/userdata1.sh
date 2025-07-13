#!/bin/bash
apt update -y
apt install -y apache2
systemctl start apache2
systemctl enable apache2
mkdir -p /var/www/html/images
echo "<h1>Welcome to Images</h1>" > /var/www/html/images/index.html
sudo ln -s /var/www/html/images/index.html /var/www/html/index.html             

