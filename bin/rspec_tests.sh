#!/bin/bash -

usage() {
    echo "
    SYNTAX

    rspec_tests.sh  [--help] [--clean-all] [--debug|-d]

    )"
    exit 1
}

if [[ "$*" =~ "--help" ]]; then
    usage
fi

output() {
    echo -e ""
    echo -e "***** \e[30;48;5;82m $@\e[0m *****"
}

while [ $# != 0 ]; do
    case $1 in
        --help|-h)
            usage
            ;;
        --clean-all)
            CLEAN_ALL="yes"
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

CLEAN_ALL=${CLEAN_ALL:-yes}

if [[ ${DEBUG_MODE} == 'yes' ]]; then
    set -eux
fi

test -d ~/tmp/vendor && output "~/tmp/vendor exists, good !" || mkdir -p ~/tmp/vendor
test -d .bundle && rm -Rf .bundle
export GEM_HOME=~/tmp/vendor

bundle install --path=~/tmp/vendor
bundle exec rake spec 'SPEC_OPTS=--format documentation'
export FUTURE_PARSER=yes
bundle exec rake syntax
bundle exec rake lint
bundle exec rake validate

if [[ "${CLEAN_ALL}" == "yes" ]]; then
    output "CLEANING UP ALL!"
    sleep 10
    bundle exec rake spec_clean
    rm -Rf .bundle/ Gemfile.lock
fi
