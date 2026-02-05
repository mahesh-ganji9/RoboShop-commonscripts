#!/bin/bash

echo -e "$G This Script used for MongoDB database Creation"

source ./common.sh

root_user_check
logfolder_check

cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
VALIDATE $? "$N mongo.repo copy process is"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "$N mongodb Installation is"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "$N enabling mongodb service is"

systemctl start mongod &>>$LOG_FILE
VALIDATE $? "$N starting mongodb service is"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>>$LOG_FILE
VALIDATE $? "$N Replacement of /etc/mongod.conf is"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "$N Restarted mongodb service is" 



script_execution_time