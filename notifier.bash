#!/usr/bin/env bash

readonly SECONDS_IN_HOUR=3600
readonly SECONDS_IN_HALF_HOUR=$((SECONDS_IN_HOUR / 2))
readonly DATE_START_WORK=9

Notifications=(
    "wash off"          #9 am
    "smoke"             #10 am
    "meet Svyat"        #11 am
    "smoke"             #12 am
    "eat"               #13 am
    "work"              #14 am
    "smoke"             #15 am
    "smoke and coffee"  #16 am
    "going to home"     #17 am
)

DateStart=$(date -d "$(date +%Y-%m-%d)" +%s)

# Lifecicle notifier 
while true; do
	# Calculate time point day
	DateNow=$(date -d "$(date '+%Y-%m-%d %H')" +%s)
	DateDiff=$(($DateNow-$DateStart))
	DateTimePoint=$(( ($DateDiff/SECONDS_IN_HOUR)-$DATE_START_WORK ))

	# Create text notifications from array by time point
	NotifyText=${Notifications[$DateTimePoint]}

	# Check if index of notifications is within the limits allowed
	NotificationsLength=${#Notifications[*]}
	if [ $DateTimePoint -lt 0 ] || [ $DateTimePoint -gt $NotificationsLength ]; then
		exit 1
	fi
	
	# Send notification to alert
    notify-send -i info "Hey `echo $USER`" "Time to $NotifyText ☺"
    sleep $SECONDS_IN_HALF_HOUR
done
