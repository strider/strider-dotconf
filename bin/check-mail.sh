#!/bin/sh

VPN=`nmcli con show --active id redhat0 | grep GENERAL.STATE | awk '{print $2}'`

if [ $VPN = 'activated' ]
then
    /usr/bin/mbsync -Va
    exit 0
fi
echo "VPN is not UP."
exit 0
