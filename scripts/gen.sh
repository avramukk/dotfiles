#!/bin/bash

# Задайте бажані значення параметрів
resolution="$1"
fps_value="$2"
bitrate="$3"
profile="$4"
pix_fmt="$5"
duration="$6"

# Визначте шлях до вихідного файлу
output_file="./source/green_audio_${resolution}_${fps_value}_${bitrate}_${profile}_${pix_fmt}_${duration}s.ts"

# Генеруємо команду ffmpeg для заданої комбінації параметрів
ffmpeg -f lavfi -i "color=c=green:s=${resolution}:r=${fps_value}" \
	-f lavfi -i "sine=frequency=220:beep_factor=4:duration=${duration}" \
	-b:v "$bitrate" -profile:v "$profile" -pix_fmt "$pix_fmt" \
	-vf "drawtext=fontsize=150:fontcolor=white:x=(w-tw)/2:y=(h-th)/2:text='%{pts\:hms} %{n}':timecode_rate=${fps_value}" \
	-c:v libx264 -c:a aac -t $duration \
	"$output_file"
echo "Згенеровано: $output_file"
# приклад: ./ffmpeg.sh 1920x1080 30 500k main yuv420p 10 30
