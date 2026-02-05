#!/bin/bash

START_TIME=$(date +%s)
Userid=$(id -u)
LOG_FOLDER=/var/log/ShellScript
LOG_FILE=/var/log/ShellScript/$0.log
SCRIPT_DIR=$PWD
MONGO_HOST=mongodb.daws88s.shop
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

root_user_check() {
      if [ $Userid -ne 0 ]; then
      echo -e "$Y please run the script with root access: $0"
      exit 1
      fi
}

logfolder_check() {
   if [ -d "$LOG_FOLDER" ]; then
      echo -e "$Y $LOG_FOLDER already exists"
   else
     echo -e "$G $LOG_FOLDER getting created"
     mkdir -p $LOG_FOLDER
     fi
     }

VALIDATE() {
    if [ $? -ne 0 ]; then
     
     echo -e "$N $2.... $R Failure"
    else
     echo -e "$N $2....$G Success"
     fi
}

nodejssetup(){
    dnf module disable nodejs -y &>>$LOG_FILE
    VALIDATE $? "Disable Module Nodejs is"

   dnf module enable nodejs:20 -y &>>$LOG_FILE
   VALIDATE $? "Enable Module Nodejs 20 version is"

   dnf install nodejs -y &>>$LOG_FILE
   VALIDATE $? "Nodejs Installation Verison is"
}

app_setup(){
    id roboshop &>>LOG_FILE
if [ $? -eq 0 ]; then
   echo "user roboshop already exists"
   
else
   useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
   VALIDATE $? "user create roboshop is"
fi


mkdir -p /app &>>$LOG_FILE
VALIDATE $? "directory /app is"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip  &&>>$LOG_FILE
VALIDATE $? "Curl Command is"

cd /app &>>$LOG_FILE
VALIDATE $? "Move to Dir /app is"

rm -rf /app/* 

unzip /tmp/catalogue.zip &>>$LOG_FILE
VALIDATE $? "unzip is"

npm install &>>$LOG_FILE
VALIDATE $? "npm installation is"

cp $SCRIPT_DIR/Catalogue.service /etc/systemd/system/ &>>$LOG_FILE
VALIDATE $? "Copying Catalogue service is"

systemctl daemon-reload &>>$LOG_FILE
VALIDATE $? "system daemon-reload"

systemctl enable Catalogue &>>$LOG_FILE
VALIDATE $? "enabling Catalogue service is"

systemctl start Catalogue &>>$LOG_FILE
VALIDATE $? "Starting Catalogue service is"
}

END_TIME=$(date +%s)
script_execution_time() {
         END_TIME=$(date +%s)
         Total_time=$(($END_TIME-$START_TIME))
         echo -e "$N Script Execution Time: $G  $Total_time"
}