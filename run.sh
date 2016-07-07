#!/bin/bash --login
source /usr/local/rvm/scripts/rvm

echo "Starting server..."

# try to determine ruby version, then install using rvm
if [ -f "Gemfile" ]; then
    # extract ruby version from gemfile
    ruby_version="ruby --latest"
    re="ruby ['\"]([0-9.]*)['\"]"
    while read line; do
        if [[ $line =~ $re ]]; then
            ruby_version=${BASH_REMATCH[1]}
            break
        fi
    done < Gemfile
    if [ ! -z "$ruby_version" ]; then
        rvm install $ruby_version
        rvm use $ruby_version
    fi

    bundle install
fi

if [ -f "/app/config.ru" ]; then
    echo "Running Ruby (rackup)"
    rvm version
    bundle exec rackup -p 80
fi
