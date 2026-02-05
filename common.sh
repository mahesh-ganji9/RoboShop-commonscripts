#!/bin/bash

Userid=$(id -u)
LOG_FOLDER=/var/log/ShellScript
LOG_FILE=/var/log/ShellScript/$0.log
SCRIPT_DIR=/home/ec2-user/RoboShop-commonscripts
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"

root_user_check()
   if [ $Userid -ne 0 ]; then
 
   echo -e "$Y please run the script with root access: $0"
   exit 1
fi