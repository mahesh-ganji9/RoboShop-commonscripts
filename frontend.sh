#!/bin/bash

appname=nginx

#This Script used to created Catalogue Service

source ./common.sh


root_user_check
logfolder_check
frontendsetup
restart_app
script_execution_time