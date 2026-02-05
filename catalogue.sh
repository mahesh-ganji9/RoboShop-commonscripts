#!/bin/bash
service_name=catalogue
appname=nodejs

source ${SCRIPT_DIR}/common.sh

root_user_check
logfolder_check
User_Validate

dnf module disable $appname -y &>>$LOG_FILE
VALIDATE $? "Disable Module $appname is"

dnf module enable $appname:20 -y &>>$LOG_FILE
VALIDATE $? "Enable Module $appname 20 version is"

dnf install $appname -y &>>$LOG_FILE
VALIDATE $? "$appname Installation Verison is"

mkdir -p /app &>>$LOG_FILE
VALIDATE $? "directory /app is"

curl -o /tmp/$service_name.zip https://roboshop-artifacts.s3.amazonaws.com/$service_name-v3.zip  &&>>$LOG_FILE
VALIDATE $? "Curl Command is"

cd /app &>>$LOG_FILE
VALIDATE $? "Move to Dir /app is"

rm -rf /app/* 

unzip /tmp/$service_name.zip &>>$LOG_FILE
VALIDATE $? "unzip is"

npm install &>>$LOG_FILE
VALIDATE $? "npm installation is"

cp $DIR/$service_name.service /etc/systemd/system/ &>>$LOG_FILE
VALIDATE $? "Copying service_name service is"

systemctl daemon-reload &>>$LOG_FILE
VALIDATE $? "system daemon-reload"

systemctl enable $service_name &>>$LOG_FILE
VALIDATE $? "$N enabling $service_name service is"

systemctl start $service_name &>>$LOG_FILE
VALIDATE $? "$N starting $service_name service is"

cp $DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
VALIDATE $? "$N mongo.repo copy process is"

dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "$N mongo installation is"

INDEX=$(mongosh --host $MONGO_HOST --quiet --eval 'db.getMongo().getDBNames().indexOf("catalogue")')

if [ $INDEX -le 0 ]; then
    mongosh --host $MONGO_HOST </app/db/master-data.js &>>$LOG_FILE
    VALIDATE $? "$N mongodb copy process"
  else
    echo -e "$Y Mongodb products already loaded"
  fi

systemctl restart $service_name &>>$LOG_FILE
VALIDATE $? "$N Restart $service_name service is"

script_execution_time