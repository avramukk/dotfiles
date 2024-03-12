#!/bin/bash

# Max retries
retries=100

# Current retry number
retry=0

# Awaiter timeout in seconds
timeout=5

until [ $retry -gt $retries ]
do
   ffmpeg -stream_loop -1 -re -i sync.mp4 -acodec copy -vcodec libx264 -framerate 30 -s 1920x1080 -b:v 800k -preset ultrafast -f mpegts $1 && break
   ((retry++))
   sleep $timeout
done
