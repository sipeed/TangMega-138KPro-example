#!/bin/bash
i=1
while [ $i -lt 10000000 ]; do
    lspci -vvd 22c2:1100 || exit 1
    echo "=========== LOOP $i ============"
    sleep 0.1
    let "i++"
done
