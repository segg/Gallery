#!/bin/bash

menu=../layout/menu.html
echo "<ul class='dropdown'><li><a href='#'>Albums</a><ul class='sub_menu'>" > $menu
find . -type d|sort -n -r|while read directory
do
	if [ "$directory" = "." ];
	then
		directory=Home
	fi
	echo $directory
	directory=${directory/.*\//}
	echo "<li><a href='#' onclick='replaceContent(\"${directory/'/\\\'/}\")'>$directory</a></li>" >> $menu
done
echo "</ul></li></ul>" >> $menu

if [ ! -d ../content ];
then
    mkdir ../content
fi

find . -type d|while read directory
do
	if [ "$directory" = "." ];
	then
		path=.
		name=Home
		file=../content/Home.html
	else
		path=${directory/.*\//}
		name=$path
		file=../content/$name.html
	fi
	echo $file
	rm "$file"
	ls "$directory"|grep -v thumb|grep jpg -i|while read line
	do
		echo "<a class='photo' rel='p' href='photos/$path/$line' title='$line'><img
        src=\"photos/$path/$line.thumb.jpg\"/></a>" >> "$file"
		#echo "<a class='photo' rel='p' href=\"photos/$path/$line\" ><img src=\"photos/$path/$line.thumb.jpg\" onmouseover=\"javascript:this.id='caller';relocate();\" onmouseout=\"javascript:this.id='';hide();\" /></a>" >> "$file"
	done
    echo '<script language="javascript">$("a.photo").fancybox();</script>' >> "$file"
	#echo '<img height=300 id="src" style="position:absolute;display:none;"></script><SCRIPT LANGUAGE="javascript">src=$("#src");function relocate(){caller=$("#caller");url=caller.attr("src");src.attr("src",url.substring(0,url.indexOf(".thumb.jpg")));var offset=caller.offset();if(offset.left<($(document).scrollLeft()+$(window).width()-500)){x=offset.left+103;}else{x=offset.left-400;}y=offset.top;if(offset.top>$(document).scrollTop()+$(window).height()-320){y=$(document).scrollTop()+$(window).height()-320;}src.css("left",x);src.css("top",y);src.css("border","10px solid white");src.fadeIn();}function hide(){src.hide();}$("a.photo").fancybox();</SCRIPT>' >> "$file"
done
