#!/bin/bash

#This Script used to created Catalogue Service

source ./common.sh


root_user_check
logfolder_check

dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "Disable module redis"

dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "Enable module redis 7"

dnf install redis -y &>>$LOG_FILE
VALIDATE $? "Install redis 7"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "Allow remote Connections"

systemctl enable redis &>>$LOG_FILE
VALIDATE $? "enable systemctl redis service"

systemctl start redis  &>>$LOG_FILE
VALIDATE $? "start systemctl redis service"