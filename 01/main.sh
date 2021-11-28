#!/bin/bash

## PLEASE do not forget to read the README.txt file

# Please change the username to the one you are currently logged-in
# Also that user need to be a sudo user as described in the README.txt 
USER='usman'

PASSWD_PATH='/etc/passwd'
CURRENT_USERS='/var/log/current_users'
HISTORY_LOGS='/var/log/hash_history.log'

# As we are storing the hash values inside the /var/log
# Therefore we need to create these files and assing them appropiate permissions
sudo touch $CURRENT_USERS
sudo touch $HISTORY_LOGS

sudo chown $USER:$USER $CURRENT_USERS
sudo chown $USER:$USER $HISTORY_LOGS

sudo chmod 777 $CURRENT_USERS
sudo chmod 777 $HISTORY_LOGS


#https://www.cyberithub.com/awk-command-in-linux-part-1/
#https://stackoverflow.com/questions/33150365/how-can-we-get-list-of-non-system-users-on-linux


# As we need to print the ":" between the username and the home_directory.
# Therefore used this special function of AWK OFS (output file separator)
# OFS actually put a separator between the selectied field as in our case we want a ":" so used it
# Taken refernce from;
# https://stackoverflow.com/questions/33150365/how-can-we-get-list-of-non-system-users-on-linux

USERS_WITH_HOMEDIR=$(awk -F: '{OFS=":" }{print $1,$6}' $PASSWD_PATH)

# Here, I had to use the delete function because the md5sum output has a trailing "~"
# Since, I only want the hash value as it is more easier to compare it
# Therefore use the bash delete charater command "tr"  with -d to delete and providing the "~"
# Taken reference from;
# https://stackoverflow.com/questions/3679296/only-get-hash-value-using-md5sum-without-filename
CUR_MD5_HASH=$(echo "$USERS_WITH_HOMEDIR" | md5sum | tr -d ' -')


# using for loop to print the values
for x in $USERS_WITH_HOMEDIR ;

    do
        echo "$x" ;
    done