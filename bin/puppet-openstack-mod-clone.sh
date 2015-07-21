#!/bin/bash

GERRIT_PROJECTS=`/usr/bin/ssh -p 29418 review.openstack.org gerrit ls-projects | grep 'openstack/puppet-' | sed 's/^openstack\///' | LC_ALL=C sort`

for project in $GERRIT_PROJECTS; do
    git clone https://github.com/openstack/$project.git
done

