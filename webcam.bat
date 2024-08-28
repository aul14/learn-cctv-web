#!/bin/bash

# FFmpeg command to transcode RTSP stream and generate HLS
ffmpeg -v verbose -i rtsp://admin:@192.168.1.201/live2.sdp -vf scale=1920:1080 -vcodec libx264 -r 25 -b:v 1000000 -crf 31 -acodec aac -sc_threshold 0 -f hls -hls_time 5 -segment_time 5 -hls_list_size 5 C:\xampp\htdocs\cctv-web\video\stream.m3u8

# Change to the directory containing your HLS files
cd C:/xampp/htdocs/cctv-web/video

# Delete old video segments, keeping the latest 5
find . -name "stream_*.ts" -type f -printf "%T@ %p\n" | sort -r -k1,1 | tail -n +6 | cut -d ' ' -f 2- | xargs rm -f

# Delete old playlist files, keeping the latest 1
find . -name "stream.m3u8" -type f -printf "%T@ %p\n" | sort -r -k1,1 | tail -n +2 | cut -d ' ' -f 2- | xargs rm -f
