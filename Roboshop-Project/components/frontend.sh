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
    echo -e "\e[1;31m[INFO] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $COMPONENT service failed"
    ;;
esac

CURL "https://dev.azure.com/DevOps-Batches/f4b641c1-99db-46d1-8110-5c6c24ce2fb9/_apis/git/repositories/a781da9c-8fca-4605-8928-53c962282b74/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"

case $? in
  0)
    echo -e "\e[1;32m[INFO] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $COMPONENT HTDOCS downloaded successfully"
    ;;
  *)
    echo -e "\e[1;31m[INFO] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $COMPONENT HTDOCS download failed"
    ;;
esac

cd /usr/share/nginx/html
rm -rf *

UNZIP "/tmp/$COMPONENT.zip"
mv static/* .
rm -rf static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
case $? in
  0)
    echo -e "\e[1;32m[INFO] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $COMPONENT default location moved successfully"
    ;;
  *)
    echo -e "\e[1;31m[INFO] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $COMPONENT default location move failed"
    ;;
esac
systemctl restart nginx
