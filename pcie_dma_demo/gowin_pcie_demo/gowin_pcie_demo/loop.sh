#!/bin/bash
m='c2h'
l=1000000
[ -n “$1” ] && m=$1
[ -n "$2" ] && l=$2
i=1
while [ $i -lt $l ]; do
    ./bin/dma_demo $m 4096 310000 > nohup.out || exit 1
    clear
    cat nohup.out 
    echo "=========== LOOP $i ============"
    echo ""
    let "i++"
done
