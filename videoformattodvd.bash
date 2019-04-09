#!/usr/bin/env bash

num=$#

if [ $num -eq 4 ];
then
	ffmpeg -i $1 -aspect $3 -target $4 $1.mpg

	if [ $4 == "pal-dvd" ];
	then
		export VIDEO_FORMAT=PAL
	else
		export VIDEO_FORMAT=NTSC
	fi

	dvdauthor -o dvd/ -t $1.mpg
	
	dvdauthor -o dvd/ -T

	mkisofs -dvd-video -o $2 dvd/

	rm -fr dvd
else
	echo "videoformattodvd.bash <video file> <iso output> <16:9|4:3> <pal-dvd|ntsc-dvd>"
	echo "Ex: ./videoformattodvd.bash myvideo.mp4 myvideo.iso 16:9 ntsc-dvd"
fi

