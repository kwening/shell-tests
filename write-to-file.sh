#!/bin/bash

number=0
#file=$1

WORKDIR=$(pwd)

while [ $number -le 7 ]; do

  number=$(cat /dev/urandom | tr -dc '0-9' | fold -w 256 | head -n 1 | head --bytes 1)
  #echo $number >> $WORKDIR/$file.log
  echo $number
  sleep 10
done

if [ $number -eq 9 ]; then
    #echo "ERROR" >> $WORKDIR/$file.log
    echo "ERROR"
fi


if [ $number -eq 8 ]; then
    #echo "SUCCESS" >> $WORKDIR/$file.log
    echo "SUCCESS"
fi

