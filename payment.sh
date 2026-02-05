#!/bin/bash

echo -e "$N This Script used for Payment Service Creation"

source ./common.sh
appname=payment

root_user_check
logfolder_check
roboshop_user_check
python_setup
script_execution_time