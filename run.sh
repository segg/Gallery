#!/bin/bash

if [ ! -d photos ];
then
    mkdir photos
    echo "Put your photos into ./photos and re-run the script"
else
    cd photos
    ../script/resize.sh
    ../script/build.sh
    echo "Done"
fi
