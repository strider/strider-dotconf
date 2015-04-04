#!/bin/bash -

set -x
exec 2>&1

usage() {
    echo "
    SYNTAX

    rspec_tests.sh  [--help] [--rspec|-r] [--syntax|-s]

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
        --rspec|-r)
            RUN_TEST="yes"
            shift
            ;;
        --syntax|-s)
            RUN_SYNTAX="yes"
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
RUN_SYNTAX=${RUN_SYNTAX:-no}

{
if [[ "${RUN_TEST}" == "yes" ]]; then
    for puppetver in 3.3.0 3.4.0 3.6.0 3.7.0; do
        test -d .bundle && rm -Rf .bundle
        export "PUPPET_GEM_VERSION=~> ${puppetver}"
        export GEM_HOME=~/tmp/vendor

        bundle install --path=~/tmp/vendor
        output "Running rspec tests against PUPPET ${puppetver}"
        bundle exec rake spec SPEC_OPTS="--format documentation --profile 10"

        output "CLEANING UP ALL!"
        sleep 5
        bundle exec rake spec_clean
        rm -Rf .bundle/ Gemfile.lock
    done
fi

if [[ "${RUN_SYNTAX}" == "yes" ]]; then
    test -d .bundle && rm -Rf .bundle
    export "PUPPET_GEM_VERSION=~> 3.7.5"
    export GEM_HOME=~/tmp/vendor

    bundle install --path=~/tmp/vendor
    export FUTURE_PARSER=yes
    output "Running puppet-lint tests"
    bundle exec rake lint
    output "Running Validate Task"
    bundle exec rake validate
fi
} 2>&1 | tee $HOME/gcha_tests_${PUP_MOD_NAME}-results.log
