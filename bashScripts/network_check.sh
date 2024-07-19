#!/bin/bash

LOG_FILE="/home/faraaz/bashScripts/logs.txt"

# Check if the network is connected
echo "Checking network connection..." >> $LOG_FILE
if ! /bin/ping -c 1 google.com &> /dev/null
then
    # Network is not connected
    echo "Network is not connected." >> $LOG_FILE
    if [ ! -f /home/faraaz/bashScripts/pre_robot_ran ]
    then
        # pre_robot has not been run
        echo "pre_robot has not been run. Running pre_robot.sh..." >> $LOG_FILE
        echo "Current user: $(whoami)" >> $LOG_FILE
        echo "Current directory: $(pwd)" >> $LOG_FILE
        echo "Attempting to create /home/faraaz/bashScripts/pre_robot_ran" >> $LOG_FILE
        ls -ld /home/faraaz/bashScripts >> $LOG_FILE
        if sudo /usr/bin/touch /home/faraaz/bashScripts/pre_robot_ran
        then
            echo "File /var/run/pre_robot_ran created successfully." >> $LOG_FILE
            # Verify file immediately after creation
            if [ -f /home/faraaz/bashScripts/pre_robot_ran ]; then
                echo "Verified: File /home/faraaz/bashScripts/pre_robot_ran exists." >> $LOG_FILE
            else
                echo "Error: File /home/faraaz/bashScripts/pre_robot_ran does not exist after creation." >> $LOG_FILE
            fi
        else
            echo "Failed to create /home/faraaz/bashScripts/pre_robot_ran." >> $LOG_FILE
        fi
        /home/faraaz/bashScripts/pre_robot.sh
    else
        # pre_robot has been run
        echo "pre_robot has been run. Running post_robot.sh and app.py..." >> $LOG_FILE
        sudo /usr/bin/rm /home/faraaz/bashScripts/pre_robot_ran
        /home/faraaz/bashScripts/post_robot.sh
        /usr/bin/python /home/faraaz/wifi-setup/app.py
	#Going for a direct connect
	echo "Going for a direct connect..." >> $LOG_FILE
    	/home/faraaz/bashScripts/post_wifi.sh
    	/usr/bin/python /home/faraaz/FarziTalkie/RaspiClient.py
    fi
else
    # Network is connected
    echo "Network is connected. Running post_wifi.sh and RaspiClient.py..." >> $LOG_FILE
    /home/faraaz/bashScripts/post_wifi.sh
    /usr/bin/python /home/faraaz/FarziTalkie/RaspiClient.py
fi
