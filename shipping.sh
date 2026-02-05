#!/bin/bash

appname=shipping

#This Script used to created Catalogue Service

source ./common.sh


root_user_check
logfolder_check


dnf install maven -y &>>$LOG_FILE
VALIDATE $? "Installing maven is"

mvn clean package &>>$LOG_FILE
VALIDATE $? "mvn creating .jar file"

mv target/shipping-1.0.jar shipping.jar  &>>$LOG_FILE
VALIDATE $? "renaming .jar file"

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

systemctl restart shipping &>>$LOG_FILE
VALIDATE $? "Restart shipping service is"