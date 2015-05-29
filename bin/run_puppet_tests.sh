#!/bin/bash -

usage() {
    echo "
    SYNTAX

    rspec_tests.sh [--help] [--init|-i] [--rspec|-r] [--syntax|-s] [--debug|-d]

    )"
    exit 1
}

if [[ "$*" =~ "--help" ]]; then
    usage
fi

if [[ "$#" = 0 ]]; then
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
        --init|-i)
            INIT_TEST="yes"
            shift
            ;;
        --rspec|-r)
            RUN_TEST="yes"
            shift
            ;;
        --syntax|-s)
            RUN_SYNTAX="yes"
            shift
            ;;
        --debug|-d)
            RUN_DEBUG="yes"
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

PUP_MOD_NAME=${PWD##*/}
RUN_TEST=${RUN_TEST:-no}
INIT_TEST=${INIT_TEST:-no}
RUN_SYNTAX=${RUN_SYNTAX:-no}
RUN_DEBUG=${RUN_DEBUG:-no}

if [[ "${RUN_DEBUG}" == "yes" ]]; then
    set -euo pipefail
    set -x
fi

if [[ "${INIT_TEST}" == "yes" ]]; then
    test -d .bundle && rm -Rf .bundle
    export GEM_HOME=~/tmp/vendor
    bundle install --path=~/tmp/vendor
fi

{
if [[ "${RUN_TEST}" == "yes" ]]; then
    for puppetver in 3.3 3.4 3.6 3.7 4.0; do
        test -d .bundle && rm -Rf .bundle
        export "PUPPET_GEM_VERSION=~> ${puppetver}.0"
        export GEM_HOME=~/tmp/vendor
        bundle install --path=~/tmp/vendor
        output "Running rspec tests against PUPPET ${puppetver}.x"
        bundle exec rake spec SPEC_OPTS="--format documentation --profile 10"

        output "CLEANING UP ALL!"
        sleep 5
        bundle exec rake spec_clean
        rm -Rf .bundle/ Gemfile.lock
    done
fi

if [[ "${RUN_SYNTAX}" == "yes" ]]; then
    test -d .bundle && rm -Rf .bundle
    export GEM_HOME=~/tmp/vendor
    export "PUPPET_GEM_VERSION=~> 3.7.0"
    bundle install --path=~/tmp/vendor
    export FUTURE_PARSER=yes
    output "Running puppet-lint tests"
    bundle exec rake lint --trace
    output "Running Validate Task"
    bundle exec rake validate

    output "CLEANING UP ALL!"
    sleep 5
    bundle exec rake spec_clean
    rm -Rf .bundle/ Gemfile.lock
fi
} 2>&1 | tee $HOME/gcha_tests_${PUP_MOD_NAME}-results.log
