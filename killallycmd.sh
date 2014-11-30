#!/bin/bash

me=`basename $0`

ps -ef | grep ycmd | grep -v `basename $0` | grep -v 'grep'

ps -ef | grep ycmd | grep -v `basename $0` | grep -v 'grep' | awk '{print $2;}' | xargs kill
