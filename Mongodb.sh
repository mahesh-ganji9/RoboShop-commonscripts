#!/bin/bash

#This Script used to created MongoDB instance

source /home/ec2-user/RoboShop-commonscripts/common.sh



root_user_check

# VALIDATE() {
#     if [ $? -ne 0 ]; then
     
#      echo -e "$R $2....Failure"
#     else
#      echo -e "$G $2....Success"
#      fi
# }

# cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
# VALIDATE $? "mongo.repo copy process is"

# dnf install mongodb-org -y &>>$LOG_FILE
# VALIDATE $? "mongodb Installation is"

# systemctl enable mongod &>>$LOG_FILE
# VALIDATE $? "enabling mongodb service is"

# systemctl start mongod &>>$LOG_FILE
# VALIDATE $? "Starting mongodb service is"

# sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>>$LOG_FILE
# VALIDATE $? "Replacement of /etc/mongod.conf is"

# systemctl restart mongod &>>$LOG_FILE
# VALIDATE $? "Restarted mongodb service is" 