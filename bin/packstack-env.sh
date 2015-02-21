#!/bin/bash -

readonly CURRENT_DIR=${2:-'.'}
PKST_REPO="https://github.com/stackforge/packstack.git"

if [ ! -d "${CURRENT_DIR}/$1" ]; then
    echo "Cloning packstack git repo from ${PKST_REPO}"
    git clone ${PKST_REPO} $1 && cd ${CURRENT_DIR}/$1/
    echo "Adding new git remote for Gerrit"
    git remote add gerrit ssh://gchamoul@review.openstack.org:29418/stackforge/packstack.git
    git review -l
    git remote add strider git@github.com:strider/packstack.git
    git fetch --all
    exit ${?}
else
    echo "${1} directory already exists !"
    exit 1
fi



