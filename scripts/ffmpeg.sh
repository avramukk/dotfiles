#!/bin/bash

# Specify the desired parameter values
resolution="$1"
fps_value="$2"
bitrate="$3"
profile="$4"
pix_fmt="$5"
duration="$6"
iframe_interval="$7" # Додано нову змінну для інтервалу I-фреймів

# Define the output file path
output_file="./source/testsrc2_${resolution}_${fps_value}_${bitrate}_${profile}_${pix_fmt}_${duration}s_${iframe_interval}iframes.ts"

# Generate ffmpeg command for the specified parameter combination
ffmpeg -f lavfi -i "testsrc=size=${resolution}:rate=${fps_value}" \
	-b:v "$bitrate" -profile:v "$profile" \
	-vf "drawtext=text='$resolution,$fps_value,$bitrate':fontsize=50:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2, drawtext=text='$profile,$pix_fmt,$duration':fontsize=50:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h+text_h)/2" \
	-c:a aac -b:a "$bitrate" -t "$duration" \
	-g "$iframe_interval" \
	"$output_file"

echo "Generated: $output_file"

# example: ./ffmpeg.sh 1920x1080 30 500k main 420 3 30
