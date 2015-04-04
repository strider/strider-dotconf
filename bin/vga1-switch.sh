#!/bin/bash -

EXT_SCREEN="None"
EXT_SCREEN=`xrandr | grep -q " connected" | awk '{print $1}' | grep -v "VGA1"`

DISPLAY_LAPTOP="eDP1"

if [ $EXT_SCREEN != 'None' ]; then
    for w in 1 2 3 4 5 6 7 8; do
        i3-msg "move workspace ${w}; to output ${EXT_SCREEN}"
    done

     for wk in {10..20}; do
         i3-msg "move workspace ${wk}; to output ${DISPLAY_LAPTOP}"
     done
fi
