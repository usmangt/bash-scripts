#!/bin/bash

## PLEASE do not forget to read the README.txt file

# Please change the username to the one you are currently logged-in
# Also that user need to be a sudo user as described in the README.txt 
USER='usman'

# Saving DATE and TIME in proper format
DATE_TIME=$(date +'%_d-%B-%Y--%H:%M:%S')

# Log paths
CURRENT_USERS='/var/log/current_users'
HISTORY_LOGS='/var/log/hash_history.log'
USER_CHANGES='/var/log/user_changes'

# As we are storing the hash values inside the /var/log
# Therefore we need to create these files and assing them appropiate permissions
sudo touch $USER_CHANGES
sudo chown $USER:$USER $USER_CHANGES
sudo chmod 777 $USER_CHANGES


# This line is optional as we are replacing the old hash values inside the '/var/log/current_users' with the new one 
# Only used it for naming convention
current_hash=$(cat $CURRENT_USERS)

# Using tail command to pick the second last line in the file via -n 2
# But also piping the head command to only pick the 1st line
# if not using "head -1" then, tail is acutally picking 2 lines (2nd last and last) 
# Therefore head commad is needed
previous_hash=$(tail -n 2 $HISTORY_LOGS| head -1)


# Doing the comparision here

if [[ "$current_hash" != "$previous_hash" ]]; then

    # If the hash are not equal then write to the user_changes file
    echo $DATE_TIME "changes occurred" >> $USER_CHANGES

else
    #if hash is same then exit with success code
    exit 0 
fi
