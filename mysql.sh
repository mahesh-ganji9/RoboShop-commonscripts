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

mysql -u root -p"$ROOT_PASS" -e "SELECT 1;" &>/dev/null
if [ $? -ne 0 ]; then
   echo -e "$R sql root password is not set..resetting now"
   mysql_secure_installation --set-root-password "$ROOT_PASS"
   else
   echo -e "$Y SQL root password is already set"
  fi

script_execution_time