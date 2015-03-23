#!/bin/bash

imapactive=`ps -ef | grep offlineimap | grep -v grep | wc -l`
mailsync="/usr/bin/offlineimap"
username=`whoami`
mailhost=`cat /home/$username/.offlineimaprc | grep remotehost | awk '{print $3}'`
online=`host $mailhost | grep "has address" | wc -l`

# If not already connected to the VPN, then let's do it !
if [[ ${online} != '1' ]]; then
    /usr/bin/nmcli con up uuid 8a200abf-0324-483b-8c2f-a162b4588cd0
    if [[ $? -eq 0 ]]; then
        online='1'
    fi
fi

# Create kerberos ticket.
/usr/bin/kinit

# kill offlineimap if active, in some rare cases it may hang
case $imapactive in
'1')
   killall offlineimap && sleep 5
;;
esac

# if you can do a DNS lookup, sync your mail
case $online in
'1')
   $mailsync
;;
esac
