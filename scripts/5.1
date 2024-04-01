#!/bin/bash

# Max retries
retries=100

# Current retry number
retry=0

# Awaiter timeout in seconds
timeout=0

until [ $retry -gt $retries ]
do
   ffmpeg -stream_loop -1 -re -i 5.1.mp4 -acodec copy -vcodec libx264 -framerate 25 -s 1920x1080 -b:v 700k -g 25 -preset ultrafast -f mpegts $1 && break
   ((retry++))
   sleep $timeout
done
