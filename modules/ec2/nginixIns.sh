#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y


sudo apt-get install -y nginx nfs-common


sudo mkdir -p /mnt/efs
sudo mount -t nfs4 -o nfsvers=4.1 ${efs_dns_name}:/ /mnt/efs


echo "<h1>Bienvenido Proyecto Terraform + AWS jorge0509</h1>" | sudo tee /mnt/efs/index.html


sudo sed -i 's|root /var/www/html;|root /mnt/efs;|' /etc/nginx/sites-available/default


sudo systemctl enable nginx
sudo systemctl restart nginx
