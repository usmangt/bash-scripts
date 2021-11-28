# ABOUT

There are 2 bash scripts in this folder.

- The 1st script named `main.sh` basically collects all the users on the system including their home directory (from the `/etc/passwd` file) and then print it out
  
  
- The 2nd script `compare.sh` actually compare the md5 checkum which gets generated insited the crontab every hour.



It saves the ouptut of **current_users** inside the `/var/log/current_users` file

Also it keeps a history of the hash values inside the `/var/log/hash_history.log` file

For any changes inside the `/etc/passwd` file , it will update the change of hash inside the `/var/log/user_changes` file



# How to install the script

## Step 1

To run this scrpit place both of the files in a directory. For e.g. if you want to run this script from your home directory for e.g. `/home/usman/bash-scripts` (offcourse you can use any other directory as well)



> **IMPORTANT**: You as a user need to be inside sudo users list as this script need priviliges in order to create files inside the `/var/log` directory (by default on Linux machine)



To find out if the user is inside the Sudo group, simply run the command;

```bash
$ sudo -l -U YOUR_USER_NAME
```

If the output tells that you are in sudoers group then all fine, as otherwise you need to contact your system-admin to add you to that group.

## Step 2

Now open the `main.sh` and `compare.sh` scripts (either using vim or and graphical editor) and inside there change the Variables value for:

```bash
USER=YOU_OWN_USERNAME #(as previously mentioned in step 1)
```

## Step 3

Now copy and paste the following inside the crontab using the command `crontab -e`

```bash
# These are variables where we are storing the paths
# You need to modify if you for e.g. have different username AND different path other than your home directory

HASH_SCRIPT_PATH=/home/usman/bash-scripts/main.sh
COMPARE_SCRIPT_PATH=/home/usman/bash-scripts/compare.sh
CURRENT_USERS=/var/log/current_users
HISTORY_LOGS=/var/log/hash_history.log


# This cron job will run every hour

0 * * * * $HASH_SCRIPT_PATH | md5sum | tr -d ' -' | tee $CURRENT_USERS >> $HISTORY_LOGS && $COMPARE_SCRIPT_PATH

# since we are saving the previous hashes inside a history file to do the comparision and update the /var/log/user_changes accordingly
# However as it will be a problem later on as file size will grow and therefore we are also running this cron job which basically do a clean up
# It will be run every first Monday of the week
# It will delete the first 10000 lines from the top of the file
# searched its syntax via Google

0 0 * * 1 sed -i '1,'1000'd' $HISTORY_LOGS
```



## Step 4

Once you have made appropiate changes then do a :wq and exit



## Step 5

***(optional) ***but to be sure, make both scripts executalbes via command 

```bash
chmod +x /home/usman/bash-scripts/main.sh
chmod +x /home/usman/bash-scripts/compare.sh
```



# HOW TO RUN THE SCRIPT

If you want to list the users along with their home directories then simply run the sciprt as;

```bash
[usman@linux bash-scripts]$ ./test.sh 
```

Then you will see a complete list of the users along with their home_directory

For the md5sum hash value and doing storing the new value for any change, you do not need to do anything as the cronjob will automatically run every hour.


You can see the changes inside the;

- `/var/log/current_users` (will only store the current hash)

- `/var/log/user_changes` (will only get a timestamp entry if the hash value gets changed after performing a compaision from the `/var/log/hash_history.log`)

- `/var/log/hash_history.log` (keep all the hash history getting generated via crontab)






