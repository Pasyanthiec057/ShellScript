#! /bin/bash

COMPONENT=Frontend
source ./components/common.sh


INFO "Setup frontend started"
INFO "Installing Nginx"
yum install epel-release
yum install nginx -y

SUCC "Installed Frontend"

