#!/bin/bash

echo -e "$N This Script used for Payment Service Creation"


source ./common.sh
appname=shipping

root_user_check
logfolder_check
app_check
java_setup
systemd_check

dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "Installing mysql"

mysql -h $MYSQL_HOST -uroot -pRoboShop@1 -e 'use cities' &>>$LOG_FILE
if [ $? -ne 0 ]; then

    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/schema.sql 
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/app-user.sql 
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/master-data.sql
    VALIDATE $? "Loaded data into MySQL"
  else
    echo "mysql db is already loaded"
fi

restart_app

script_execution_time