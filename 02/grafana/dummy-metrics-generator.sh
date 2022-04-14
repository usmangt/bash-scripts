#!/bin/bash

## DATABASE INFORMATION
##
DB_USER='grafana';
DB_PASSWD='secret';
DB_NAME='grafanadb';
TABLE='metrics';

## CREATE TABLE metrics IF NOT EXISTS
#CREATE TABLE IF NOT EXISTS metrics (dt VARCHAR(50) NOT NULL,cpu VARCHAR(30) NOT NULL,iowait VARCHAR(30) NOT NULL,idle VARCHAR(30) NOT NULL);


## GENERATING THE DUMMY VALUES
##

## timestamp
DT=$(date +%F_%T)
#echo $DT

## cpu
a=3
b=17
CPU="$((a+RANDOM%(b-a))).$((RANDOM%999))"
#echo $CPU


## iowait
IOWAIT=$(seq 0 .01 1 | shuf | head -n1)
#echo $IOWAIT

## idle
IDLE=$(awk -v min=40 -v max=100 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
#echo $IDLE


## mysql command to insert value into the table

mysql --user=$DB_USER --password=$DB_PASSWD $DB_NAME <<EOF
CREATE TABLE IF NOT EXISTS metrics (dt VARCHAR(50) NOT NULL,cpu VARCHAR(30) NOT NULL,iowait VARCHAR(30) NOT NULL,idle VARCHAR(30) NOT NULL);
INSERT INTO $TABLE (\`dt\`, \`cpu\`, \`iowait\`, \`idle\`) VALUES ("$DT", "$CPU", "$IOWAIT", "$IDLE");
EOF
