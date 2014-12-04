#!/bin/bash

me=`basename $0`

if [ x"$1" = x"show" ]; then
    ps -ef | grep ycmd | grep -v `basename $0` | grep -v 'grep'
elif [ x"$1" = x"kill" ]; then
    ps -ef | grep ycmd | grep -v `basename $0` | grep -v 'grep'
    ps -ef | grep ycmd | grep -v `basename $0` | grep -v 'grep' | awk '{print $2;}' | xargs kill
else
    echo "Input show or kill"
fi

