#!/bin/bash

for file in $*
do
    puppet parser validate $file >&2
    if [ $? -ne 0 ]; then
        exit 1
    fi
done
