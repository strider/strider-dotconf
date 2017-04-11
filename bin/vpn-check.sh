#!/bin/bash

set -e

while [ "true" ]
do
    CON=`nmcli net con`
	VPNCON=`nmcli con show --active id redhat0 | grep GENERAL.STATE | awk '{print $2}'`
    if [[ $CON = 'full' ]]; then
        if [[ $VPNCON = 'activated' ]]; then
            echo "Already connected to the Red Hat VPN!"
        else
            echo "Disconnected, trying to reconnect..."
            (sleep 1s && ~/bin/gentoken.sh --vpn-connect)
        fi
    else
        echo "No Network!"
    fi
	sleep 30
done
