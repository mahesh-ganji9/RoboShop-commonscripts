#!/bin/bash

appname=catalogue

#This Script used to created Catalogue Service

source ./common.sh

root_user_check
logfolder_check
app_setup
nodejssetup
systemd_check

cp /home/ec2-user/RoboShop-commonscripts/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
VALIDATE $? "mongo.repo copy process is"

dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "mongo installation is"

INDEX=$(mongosh --host $MONGO_HOST --quiet --eval 'db.getMongo().getDBNames().indexOf("catalogue")')

if [ $INDEX -le 0 ]; then
    mongosh --host $MONGO_HOST </app/db/master-data.js &>>$LOG_FILE
    VALIDATE $? "mongodb copy process"
  else
    echo -e "$Y Mongodb products already loaded"
  fi

restart_app

script_execution_time