#!/bin/sh
# Helper script to run (almost) any individual Puppet RSpec test.
# Usage: ./scripts/spec-runner <specfile[:line]> ...

set -eux

PUPPET_ROOT=$(pwd)

if test "$PUPPET_ROOT" != "$(pwd -P)"; then
    echo >&2 "error: spec-runner must be executed in $PUPPET_ROOT"
    exit 1
fi

SPEC=
ROOT=
RSPEC_OPTS="'SPEC_OPTS=--format documentation'"

parse_args() {
    SPEC="$1"
    ROOT=.

    case "$SPEC" in
    "")
        echo >&2 "error: spec file missing"
        exit 1
        ;;
    site/*|dist/*|modules/*)
        ROOT=$(echo "$SPEC" | cut -d/ -f-2)
        SPEC=$(echo "$SPEC" | cut -d/ -f3-)
        ;;
    ./site/*|./dist/*|./modules/*)
        ROOT=$(echo "$SPEC" | cut -d/ -f-3)
        SPEC=$(echo "$SPEC" | cut -d/ -f4-)
        ;;
    *)
        ;;
    esac
}

prepare_env() {
    cd $PUPPET_ROOT

    if test $ROOT != .; then
        echo "cd $ROOT"
        cd "$ROOT"
    fi

    if test -z "$BUNDLE_GEMFILE"; then
        if test -f Gemfile; then
            BUNDLE_GEMFILE="$ROOT/Gemfile"
        else
            BUNDLE_GEMFILE="$PUPPET_ROOT/Gemfile"
        fi
        export BUNDLE_GEMFILE
    fi

    # Try to install missing gems
    test -d ~/tmp/vendor && output "~/tmp/vendor exists, good !" || mkdir -p ~/tmp/vendor
    test -d .bundle && rm -Rf .bundle
    export GEM_HOME=~/tmp/vendor

    bundle check >/dev/null || bundle install --path=~/tmp/vendor

    # Prepare fixtures
    if test -f Rakefile; then
        tasks=

        if grep -q puppetlabs_spec_helper Rakefile 2>/dev/null; then
            rm -rf spec/fixtures/manifests spec/fixtures/modules
            tasks="spec_prep"
        elif grep -q prepare_manifests_for_rspec Rakefile 2>/dev/null; then
            tasks="test:prepare_modules test:prepare_manifests_for_rspec"
        else
            : # unknown Rakefile
            return
        fi

        bundle exec rake $tasks
    fi
}

run_specs() {
    bundle exec ${RSPEC-rspec} $RSPEC_OPTS $SPEC
}

for spec in "$@"; do
    parse_args "$spec"
    prepare_env
    run_specs
done
