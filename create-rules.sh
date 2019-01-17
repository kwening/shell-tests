#!/bin/bash

WORKDIR=$(pwd)

count=`ls -1 $WORKDIR/*.rule 2>/dev/null | wc -l`
if [ $count != 0 ]
then 
    echo "rule files exist - skipping creation"
    exit 0
fi 


for letter in {a..e}
do
    echo "Creating rule for $letter"
    echo $letter > $WORKDIR/$letter.rule
done


