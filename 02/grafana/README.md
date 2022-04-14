# ABOUT

This script just create a dummy databases inside the MySQL server which can be used to generate metrics inside grafana


# How to install the script

## Step 1

Follow the link to this video tutorial
https://www.youtube.com/watch?v=CjABEnRg9NI



> **IMPORTANT**: You as a user need to be inside sudo users list as this script need priviliges in order to create files inside the machine



## Step 2

Now copy and paste the following inside the crontab using the command `crontab -e`

```bash
# These are variables where we are storing the paths
# You need to modify if you for e.g. have different username AND different path other than your home directory

PATH_TO_SCRIPT=/root/dummy-metrics-generator.sh
PATH_TO_LOGS=/root/dummy-metrics-generator.log

# This cron job will run 5 minutes

*/5 * * * * $PATH_TO_SCRIPT >> PATH_TO_LOGS 2>&1

```



## Step 3

Once you have made appropiate changes then do a :wq and exit



## Step 5

***(optional) ***but to be sure, make both scripts executalbes via command 

```bash
chmod +x /root/dummy-metrics-generator.sh
chmod +x /root/dummy-metrics-generator.log
```



# HOW TO RUN THE SCRIPT

If you want to list the users along with their home directories then simply run the sciprt as;

```bash
[root@server]$ ./dummy-metrics-generator.sh
```

