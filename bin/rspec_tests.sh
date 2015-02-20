#!/bin/bash - 

set -x

test -d vendor && rm -Rf vendor || mkdir vendor
test -d .bundle && rm -Rf .bundle
export GEM_HOME=./vendor
bundle install --path=./vendor
bundle exec rake spec

sleep 10
rm -Rf vendor/ .bundle/ 
