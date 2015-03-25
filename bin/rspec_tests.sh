#!/bin/bash -

usage() {
    echo "
    SYNTAX

    rspec_tests.sh  [--help] [--clean-all] [--debug|-d]
                    [--run-rspec-tests|-r]

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
        --run-rspec-tests|-r)
            RSPEC_TEST="yes"
            shift
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

CLEAN_ALL=${CLEAN_ALL:-no}
RSPEC_TEST=${RSPEC_TEST:-no}

if [[ ${DEBUG_MODE} == 'yes' ]]; then
    set -eux
fi

test -d ~/tmp/vendor && output "~/tmp/vendor exists, good !" || mkdir -p ~/tmp/vendor
test -d .bundle && rm -Rf .bundle
export GEM_HOME=~/tmp/vendor

bundle install --path=~/tmp/vendor

if [[ "${RSPEC_TEST}" == "yes" ]]; then
    output "Running rspec tests"
    bundle exec rake spec 'SPEC_OPTS=--format documentation'
fi

export FUTURE_PARSER=yes
output "Running puppet-lint tests"
bundle exec rake lint
output "Running syntax, validate and metadata-json-lint tests"
bundle exec rake validate

if [[ "${CLEAN_ALL}" == "yes" ]]; then
    output "CLEANING UP ALL!"
    sleep 10
    bundle exec rake spec_clean
    rm -Rf .bundle/ Gemfile.lock
fi
