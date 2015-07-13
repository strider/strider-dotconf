#!/bin/bash

usage() {
    echo "
    SYNTAX

    prepare-opm-update.sh [--help|-h] [--branch|-b <master>]
                          [--from-openstack-only|-s]
                          [--debug|-d]

    )"
    exit 1
}

if [[ "$*" =~ "--help" ]]; then
    usage
fi

while [ $# != 0 ]; do
    case $1 in
        --help|-h)
            usage
            ;;
        --branch|-b)
            BR=$2
            shift
            ;;
        --from-openstack-only|-s)
            OPENSTACK="yes"
            shift
            ;;
        --debug|-d)
            DEBUG="yes"
            shift
            ;;
        *)
            echo "invalid arg -- $1"
            usage
            exit 1
            ;;
    esac
    shift
done

output() {
    echo -e ""
    echo -e "***** \e[30;48;5;82m $@\e[0m *****"
}

BRANCH=${BR:-master}
OPENSTACK_ONLY=${OPENSTACK:-no}
DEBUG_MODE=${DEBUG:-no}
OPM_REPO_URL="git://github.com/redhat-openstack/openstack-puppet-modules.git"
PM_TMP_DIR="/tmp/pm-tmp"
OPM_ORIG_DIR="/tmp/opm-orig"
OPM_UPDATE_DIR="/tmp/opm-update"
PUPPETFILE="${OPM_ORIG_DIR}/Puppetfile"

if [[ ${DEBUG_MODE} == 'yes' ]]; then
    set -x
fi

if [[ ${BRANCH} != 'master' ]]; then
    output "${BR} branch is not supported yet !"
    usage
fi

# Cleaning up the tmp directories
if [[ -d ${PM_TMP_DIR} ]]; then
    rm -Rf "${PM_TMP_DIR}/"
fi

if [[ -d ${OPM_ORIG_DIR} ]]; then
    rm -Rf "${OPM_ORIG_DIR}/"
fi

if [[ -d ${OPM_UPDATE_DIR} ]]; then
    rm -Rf "${OPM_UPDATE_DIR}/"
fi

output "Cloning OPM"
count=0
until timeout -s SIGKILL 5m git clone ${OPM_REPO_URL} --branch ${BRANCH} ${OPM_ORIG_DIR}; do
    count=$(($count + 1))
    echo "remote clone failed"
    if [ $count -eq 3 ]; then
        echo "max retries reached"
        exit 1
    fi
    sleep 10
done

count=0
until timeout -s SIGKILL 5m git clone ${OPM_REPO_URL} --branch ${BRANCH} ${OPM_UPDATE_DIR}; do
    count=$(($count + 1))
    echo "remote clone failed"
    if [ $count -eq 3 ]; then
        echo "max retries reached"
        exit 1
    fi
    sleep 10
done

cd $OPM_ORIG_DIR
for MODULE in `grep '^mod.*' ${PUPPETFILE} | cut -d"'" -f2`; do
    GIT_URL=$(grep -e "^mod.*${MODULE}" -A2 ${PUPPETFILE} | grep ':git.*=>' | cut -d"'" -f2)
    GIT_COMMIT=$(grep -e "^mod.*${MODULE}" -A2 ${PUPPETFILE} | grep ':commit.*=>' | cut -d"'" -f2)

    if [[ ${OPENSTACK_ONLY} == 'yes' ]] && [[ ! ${GIT_URL} =~ 'openstack' ]]; then
        output "${MODULE} is not coming from openstack"
    else
        cd ${OPM_UPDATE_DIR}

        if [[ -d ${MODULE} ]]; then
            mv ${MODULE} ${MODULE}_orig
            rm -rf "${MODULE}_orig/"
        fi

        output "Cloning ${MODULE}"
        git clone ${GIT_URL} ${MODULE}
        cd ${MODULE}
        output "Checking out ${BRANCH} for ${MODULE}"
        git checkout ${BRANCH}
        COMMIT=$(git show | head -n1 | awk '{print $2}')

        if [[ ${GIT_COMMIT} != ${COMMIT} ]]; then
            echo "Update ${MODULE} to ${COMMIT}" > COMMIT_MESSAGE
            echo ''  >> COMMIT_MESSAGE
            output "List of the commits"
            git log --pretty=oneline ${GIT_COMMIT}..${BRANCH} | tee -a COMMIT_MESSAGE
            cd ${OPM_ORIG_DIR}
            output "Using Bade for goodness!"
            bade update --module ${MODULE} --hash ${COMMIT}
            git add Puppetfile
            git commit -m "$(cat ${OPM_UPDATE_DIR}/${MODULE}/COMMIT_MESSAGE)" -s
        else
            cd ${OPM_ORIG_DIR}
            output "${MODULE} is already up-to-date, wow!"
        fi
    fi
done

cd ${OPM_ORIG_DIR}
git remote add my-fork git@github.com:strider/openstack-puppet-modules.git
git fetch --all
cd ${OPM_ORIG_DIR}
git checkout -b openstack-pm-update-master
output "Ready to push the Pull-Request !"
