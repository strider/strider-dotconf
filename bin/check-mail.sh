#!/bin/sh

notmuch="/usr/bin/notmuch"
RH_NETWORK=0

VPN=$(nmcli con show --active id redhat0 | grep GENERAL.STATE | awk '{print $2}')
CHECK_RH_NET=$(ping -q -c5 mail.corp.redhat.com > /dev/null)

if $CHECK_RH_NET; then
    RH_NETWORK=1
fi

function notmuch_run {
    $notmuch new --quiet

    $notmuch tag +inbox -- "folder:redhat-gmail/INBOX and not tag:inbox"
    $notmuch tag +sent -- "folder:redhat-gmail/Sent and not tag:sent"

    # French Mailing lists
    $notmuch tag +list +france +france-list -- "folder:redhat-gmail/ML.France-list and not tag:france"
    $notmuch tag +list +france +french-associate -- "folder:redhat-gmail/ML.French-associates and and not tag:france"
    $notmuch tag +list +france +cdg-list -- "folder:redhat-gmail/ML.cdg-list and and not tag:france"

    # Non-technical Mailing lists
    $notmuch tag +list +nontech +announce -- "folder:redhat-gmail/ML.announce-list and not tag:nontech"
    $notmuch tag +list +nontech +memo -- "folder:redhat-gmail/ML.memo-list and not tag:nontech"
    $notmuch tag +list +nontech +friday -- "folder:redhat-gmail/ML.Friday-list and not tag:nontech"
    $notmuch tag +list +nontech +remotees -- "folder:redhat-gmail/ML.Remotees-list and not tag:nontech"
    $notmuch tag +list +nontech +neurodiversity -- "folder:redhat-gmail/ML.Neurodiversity and not tag:nontech"

    # Technical Mailing lists
    $notmuch tag +list +tech +tech-list -- "folder:redhat-gmail/ML.RH-Tech-list and not tag:tech"
    $notmuch tag +list +tech +kni -- "folder:redhat-gmail/ML.KNI-DEVEL and not tag:tech"

    # OpenStack Mailing lists
    $notmuch tag +list +openstack +rdo -- "folder:redhat-gmail/ML.OST-RDO-LIST and not tag:openstack"
    $notmuch tag +list +openstack +rhos-dev -- "folder:redhat-gmail/ML.OST-RH-OPENSTACK-DEVEL and not tag:openstack"
    $notmuch tag +list +openstack +rhos-pgm -- "folder:redhat-gmail/ML.OST-RH-OPENSTACK-PGM and not tag:openstack"
    $notmuch tag +list +openstack +status -- "folder:redhat-gmail/ML.OST-RH-OPENSTACK-STATUS and not tag:openstack"
    $notmuch tag +list +openstack +dfgui -- "folder:redhat-gmail/ML.OST-RH-OPENSTACK-UI and not tag:openstack"
    $notmuch tag +list +openstack +rhos-tech -- "folder:redhat-gmail/ML.OST-RHOS-TECH and not tag:openstack"
    $notmuch tag +list +openstack +ooo -- "folder:redhat-gmail/ML.OST-UPSTREAM-TRIPLEO-DEV and not tag:openstack"
}

if [ "$VPN" = "activated" ] || [ "$RH_NETWORK" -eq 1 ]; then
    /usr/bin/mbsync -Va
    notmuch_run
    exit 0
fi
echo "VPN is not UP."
exit 0
