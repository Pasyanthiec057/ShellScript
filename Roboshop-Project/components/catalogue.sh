#! /bin/bash

COMPONENT=catalogue
source ./components/common.sh

INFO "Installing nodejs"
NODEJS_INSTALL
RESULT $? "Nodejs installation"

INFO "Creating application user"
id roboshop &>> "$LOG_OUT"
case $? in
  0)
  RESULT 0 "Application user created"
  ;;
  1)
    USERADD
    RESULT $? "Application user creation"
  ;;
esac





CURL "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/d62914b9-61e7-4147-ab33-091f23c7efd4/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
cd /home/roboshop
mkdir -p $COMPONENT
RESULT $? "$COMPONENT directory creation"
cd $COMPONENT
UNZIP "/tmp/$COMPONENT.zip"
RESULT $? "Unzip files"
yum install npm -y
npm install --unsafe-perm
chown roboshop:roboshop /home/roboshop/$COMPONENT -R

sed -i -e 's/MONGO_DNSNAME/172.31.47.156/' /home/roboshop/catalogue/systemd.service
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
RESULT $? "Daemon reload"
systemctl enable catalogue &>> "$LOG_OUT"
RESULT $? "Catalogue service enable"
systemctl start catalogue &>> "$LOG_OUT"
RESULT $? "Catalogue service start"