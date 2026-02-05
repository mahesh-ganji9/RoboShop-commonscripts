#!/bin/bash

START_TIME=$(date +%s)
Userid=$(id -u)
LOG_FOLDER=/var/log/ShellScript
LOG_FILE=/var/log/ShellScript/$0.log
SCRIPT_DIR=/home/ec2-user/RoboShop-commonscripts
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"

echo $START_TIME
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
     echo -e "$Y $LOG_FOLDER getting created"
     mkdir -p $LOG_FOLDER
     fi
}


VALIDATE() {
    if [ $? -ne 0 ]; then
     
     echo -e "$R $2....Failure"
    else
     echo -e "$2....$G Success $N"
     fi
}



script_execution_time() {
         Total_time=$(($END_TIME-$START_TIME))
         echo -e "$G Script Execution Time: $Total_time"
}