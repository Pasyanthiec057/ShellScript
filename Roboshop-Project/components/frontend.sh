#! /bin/bash

COMPONENT=Frontend
source ./components/common.sh


INFO "Setup frontend started"
INFO "Installing Nginx"
yum install epel-release -y &>> $LOG_OUT
yum install nginx -y &>> $LOG_OUT

SUCC "Installed Frontend"

systemctl enable nginx &>> $LOG_OUT
systemctl start nginx &>> $LOG_OUT

case $? in
  0)
    echo -e "\e[1;32m[INFO] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $COMPONENT service started"
    ;;
  *)
    echo -e "\e[1;32m[INFO] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $COMPONENT service failed"
    ;;
esac
#SERVICE "$COMPONENT"

