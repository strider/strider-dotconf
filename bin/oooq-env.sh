#!/bin/bash -

set -e

OOOQ_DIR="$HOME/tmp/oooq"
OOOQ_REPO="https://github.com/openstack/tripleo-quickstart"

function remove_oooq_dir {
    if [ -d "$OOOQ_DIR" ]; then
        echo "oooq clone already exists -  Deleting it"
        rm -Rf "$OOOQ_DIR"
    else
        echo "No existing clone!"
    fi
}

function oooq_cloning {
    echo "Cloning openstack/tripleo-quickstart"
    git clone "${OOOQ_REPO}" "$OOOQ_DIR"
}

remove_oooq_dir
oooq_cloning
