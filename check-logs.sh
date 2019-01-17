#!/bin/bash

WORKDIR=$(pwd)

for filename in $WORKDIR/*.log; do
    filename="${filename##*/}"
    filename="${filename%.*}"

#    echo "Checking $filename"

    PID=$(pgrep -f "write-to-file.sh $filename")

    if grep -q "ERROR" "$WORKDIR/$filename.log"; then 
	echo "Checking $filenam : ERROR"
	rm $WORKDIR/$filename.rule
	mv $WORKDIR/$filename.log $WORKDIR/archive/error/$filename.log
    elif grep -q "SUCCESS" "$WORKDIR/$filename.log"; then
	echo "Checking $filename : SUCCESS"
	rm $WORKDIR/$filename.rule
	mv $WORKDIR/$filename.log $WORKDIR/archive/success/$filename.log
    elif [ -z $PID ]; then
        echo "Checking $filename : TERMINATED"
	rm $WORKDIR/$filename.rule
	mv $WORKDIR/$filename.log $WORKDIR/archive/success/$filename.log
    else
        echo "Checking $filename ; RUNNING (PID $PID)"
    fi
done

