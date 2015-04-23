#!/bin/bash

# Fast fail the script on failures.   
set -e

# Make sure to grab the build path that protobuf was built to
export PATH=$TRAVIS_BUILD_DIR/bin:$PATH

make run-tests
