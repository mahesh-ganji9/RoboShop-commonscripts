#!/bin/bash

echo -e "$G This Script used for Rabbitmq database Creation"

source ./common.sh
root_user_check
logfolder_check

cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
VALIDATE $? "rabbitmq copy process"

dnf install rabbitmq-server -y &>>$LOG_FILE
VALIDATE $? "Installing rabbitmq server"

systemctl enable rabbitmq-server &>>$LOG_FILE
VALIDATE $? "enable rabbitmq systemctl service"

systemctl start rabbitmq-server &>>$LOG_FILE
VALIDATE $? "start systemctl rabbitmq service"

rabbitmqctl list_users | grep -w roboshop &>>$LOG_FILE
if [ $? -ne 0 ];then
    echo -e "$Y Adding user roboshop in Progress....$N"
    rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
    rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
  else
    echo -e "$Y user roboshop already exists $N"
fi
    
script_execution_time