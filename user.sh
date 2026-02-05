#!/bin/bash

appname=user

#This Script used to creat User Service

source ./common.sh


root_user_check
logfolder_check
app_setup
nodejssetup
systemd_check

script_execution_time