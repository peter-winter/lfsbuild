#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "FINAL SYSTEM --- Building bc"

build_bc()
{
    CC=gcc ./configure --prefix=/usr -G -O3 -r
    make
    make test 2>&1 | tee /test_output/bc.txt
    make install
}


build_package "^bc" build_bc skip_dedicated_build_dir
