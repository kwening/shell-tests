#!/bin/bash

WORKDIR=$(pwd)

for filename in $WORKDIR/*.log; do
    filename="${filename##*/}"
    filename="${filename%.*}"

    echo "Checking $filename"

    PID=$(pgrep -f "write-to-file.sh $filename")

    if grep -q "ERROR" "$WORKDIR/$filename.log"; then 
	echo "Error"
	rm $WORKDIR/$filename.rule
	mv $WORKDIR/$filename.log $WORKDIR/archive/error/$filename.log
    elif grep -q "SUCCESS" "$WORKDIR/$filename.log"; then
	echo "Success"
	rm $WORKDIR/$filename.rule
	mv $WORKDIR/$filename.log $WORKDIR/archive/success/$filename.log
    elif [ -z $PID ]; then
        echo "Terminated"
	rm $WORKDIR/$filename.rule
	mv $WORKDIR/$filename.log $WORKDIR/archive/success/$filename.log
    else
	echo "Running : PID $PID"
    fi
done

