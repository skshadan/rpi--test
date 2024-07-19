#!/bin/bash

LOG_FILE="/home/faraaz/bashScripts/final_logs.txt"

# Check if the network is connected
echo "Checking network connection..." >> $LOG_FILE
if /bin/ping -c 1 google.com &> /dev/null; then
    # Network is connected
    echo "Network is connected. Running post_wifi.sh and RaspiClient.py..." >> $LOG_FILE
    /home/faraaz/bashScripts/post_wifi.sh
    while ! /usr/bin/python /home/faraaz/FarziTalkie/RaspiClient.py; do
        echo "RaspiClient.py encountered an error. Retrying in 5 seconds..." >> $LOG_FILE
        sleep 5
    done
    echo "RaspiClient.py executed successfully." >> $LOG_FILE
else
    # Network is not connected
    echo "Network is not connected. Running pre_robot.sh, post_robot.sh, and app.py..." >> $LOG_FILE
    /home/faraaz/bashScripts/pre_robot.sh
    /home/faraaz/bashScripts/post_robot.sh
    /usr/bin/python /home/faraaz/wifi-setup/app.py
    # Going for a direct connect
    echo "Going for a direct connect..." >> $LOG_FILE
    /home/faraaz/bashScripts/post_wifi.sh
    while ! /usr/bin/python /home/faraaz/FarziTalkie/RaspiClient.py; do
        echo "RaspiClient.py encountered an error. Retrying in 5 seconds..." >> $LOG_FILE
        sleep 5
    done
    echo "RaspiClient.py executed successfully." >> $LOG_FILE
fi
