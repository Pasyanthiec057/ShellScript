#! /bin/bash

COMPONENT=Frontend
source ./components/common.sh


INFO "Setup frontend started"
INFO "Installing Nginx"
yum install epel-release -y &>> $LOG_OUT
yum install nginx -y &>> $LOG_OUT

SUCC "Installed Frontend"

