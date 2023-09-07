#!/bin/bash
sudo apt-get update
sudo apt-get install git -y

git clone https://github.com/dnisha/rolling-deployment.git 
cd rolling-deployment
git checkout version

sudo cp index.html /var/www/html/index.nginx-debian.html


