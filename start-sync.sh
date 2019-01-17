#!/bin/bash

WORKDIR=$(pwd)

$WORKDIR/check-logs.sh

# Check if log file exists (running)
count=`ls -1 $WORKDIR/*.log 2>/dev/null | wc -l`
if [ $count != 0 ]
then
    echo "log files exist - skipping execution"
    exit 0
fi

$WORKDIR/create-rules.sh

for filename in $WORKDIR/*.rule; do
    filename="${filename##*/}"
    filename="${filename%.*}"

    echo "Starting process for $filename"

    $WORKDIR/write-to-file.sh $filename  2>&1 > $WORKDIR/$filename.log &
    #tail -f $WORKDIR/$filename.rule 2>&1 > $WORKDIR/$filename.log &
done
