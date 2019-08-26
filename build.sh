#!/usr/bin/env bash
set -o errexit #abort if any command fails

# probably need dependencies for this to work
# sudo apt-get install ruby ruby-dev zlib1g-dev liblzma-dev
# gem upate --system
# bundle install

sudo bundle exec middleman build --clean
cp -r build/* .
rm -fr build
