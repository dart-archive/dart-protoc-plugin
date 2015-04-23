#!/bin/bash

# Travis currentnly uses ubuntu precise
# Precise has protobuf 2.4 http://packages.ubuntu.com/source/precise/devel/protobuf
# We need protobuf 2.5

# Fast fail the script on failures.   
set -e

# print commands as they run
set -x

### NEED TO GET PROTOC 2.5.0
curl -# -O https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz
gunzip protobuf-2.5.0.tar.gz 
tar -xvf protobuf-2.5.0.tar 
pushd protobuf-2.5.0
./configure --prefix=$TRAVIS_BUILD_DIR
make
make install
popd
