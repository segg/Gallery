#!/bin/bash
ls *.jpg *.JPG */*.jpg */*.JPG|grep -v thumb|while read file
do
	echo $file
	thumbfile=$file.thumb.jpg
	height=`identify "$file"|sed 's/.*JPEG //'|cut -d" " -f1|cut -d"x" -f2`
	if [ $height -gt 800 ];
	then
		convert "$file" -verbose -resize 800x800  "$file"
	fi
	if [ -f "$thumbfile" ];
	then
		height=`identify "$thumbfile"|sed 's/.*JPEG //'|cut -d" " -f1|cut -d"x" -f2`
		if [ $height -ne 90 ];
		then
			convert "$file" -verbose -resize 200x90 "$thumbfile"
		fi
	else
		convert "$file" -verbose -resize 200x90 "$thumbfile"
	fi
#	if [ -f "$thumbfile" ];
#	then
#		height=`identify "$thumbfile"|sed 's/.*JPEG //'|cut -d" " -f1|cut -d"x" -f2`
#		if [ $height -gt 72 ];
#		then
#			width=`identify "$thumbfile"|sed 's/.*JPEG //'|cut -d" " -f1|cut -d"x" -f1`
#			diff=`expr $height - 72`
#			diff=`expr $diff / 2`
#			convert "$thumbfile" -shave 0x$diff  "$thumbfile"
#		fi
#	fi
done


