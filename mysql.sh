#!/bin/bash

echo -e "$G This Script used for mysql database Creation"

source ./common.sh

ROOT_PASS="RoboShop@1"
root_user_check
logfolder_check

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "Installing Mysql server"

systemctl enable mysqld &>>$LOG_FILE
VALIDATE $? "enable mysql systemctl service"

systemctl start mysqld  &>>$LOG_FILE
VALIDATE $? "start systemctl mysql service"

mysql_secure_installation --set-root-pass RoboShop@1
VALIDATE $? "Set mysql root pass"

script_execution_time