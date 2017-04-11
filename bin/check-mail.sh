#!/bin/sh

RH_NETWORK=0

VPN=$(nmcli con show --active id redhat0 | grep GENERAL.STATE | awk '{print $2}')
CHECK_RH_NET=$(ping -q -c5 mail.corp.redhat.com > /dev/null)

if $CHECK_RH_NET; then
    RH_NETWORK=1
fi

if [ "$VPN" = "activated" ] || [ "$RH_NETWORK" -eq 1 ];
then
    /usr/bin/mbsync -Va
    exit 0
fi
echo "VPN is not UP."
exit 0
