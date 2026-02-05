#!/bin/bash

echo -e "$N This Script used for Dispatch Service Creation"

source ./common.sh
appname=dispatch



root_user_check
logfolder_check
roboshop_user_check

dnf install golang -y &>>$LOG_FILE
VALIDATE $? "Installing golang is"

dispatch_app
script_execution_time 