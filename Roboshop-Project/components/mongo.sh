#! /bin/bash

COMPONENT=Mongo

source  ./components/common.sh


INFO "Setup mongo db repos started"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo

RESULT $? "Set up Mongo"
INFO "Installing mongo"
yum install -y mongodb-org  &>> "$LOG_OUT"
RESULT $? "mongo db installation"

systemctl enable mongod
systemctl start mongod
RESULT $? "mongo service start"

sed -i 's/127.0.0.1/0.0.0.0/'  /etc/mongod.conf &>> "$LOG_OUT"
RESULT $? "IP address in the configuration file change"

systemctl restart mongod
RESULT $? "mongo service restart"

CURL "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/03f2af34-e227-44b8-a9f2-c26720b34942/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
RESULT $? "download database schema"

UNZIP "/tmp/$COMPONENT.zip"
RESULT $? "Unzip files"

mongo < catalogue.js &>> "$LOG_OUT"
mongo < users.js &>> "$LOG_OUT"
RESULT $? "Schema load"
#SUCC "Installed mongo"
#FAIL "Installing mongo failed"
