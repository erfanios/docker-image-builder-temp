#!/usr/bin/env bash
# SCRIPT: cron.sh 
# AUTHOR: ...
# DATE: 2025-06-22T12:16:18
# REV: 1.0
# ARGUMENTS: Same as the `docker-build-and-push.sh`: [1: docker username] [2: docker image name]
#
# PURPOSE: This for being called from the cron job. I calls the download and buid and push to docker. 
#
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
# set -e # Break on the first failure

DIR_NAME="$(basename "$(cd "$(dirname "$0")" && pwd)")"
log="/tmp/cron-${DIR_NAME}.log"

function LOG {
	echo "$@" >> $log
}

LOG "-----------------------------------"
LOG "-----------------------------------"

LOG "$(date '+%F_%T') Running download/update and upload"

LOG "-----------------------------------"
LOG "-----------------------------------"

if [ $# -eq 0 ]; then 
	LOG "Error: You should insert your username for docker hub and name of the image on the docker hub as first and second argument";
	exit 1;
fi

# do some build here

./docker-build-and-push.sh "$@" >>${log} 2>&1
