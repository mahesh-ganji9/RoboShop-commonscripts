#!/bin/bash

echo -e "$N This Script used for Payment Service Creation"

source ./common.sh
appname=payment

root_user_check
logfolder_check
app_setup
python_setup
systemd_check
script_execution_time