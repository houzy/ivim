#!/bin/bash

ps -ef | grep ycmd | grep -v grep | awk '{print $2;}' | xargs kill
