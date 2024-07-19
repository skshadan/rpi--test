#!/bin/bash

# File path
FILE_PATH="/var/run/pre_robot_ran2"

# Create the file
touch $FILE_PATH

# Check if the file was created successfully
if [ -f $FILE_PATH ]; then
    echo "File $FILE_PATH created successfully."
else
    echo "Failed to create $FILE_PATH."
fi
