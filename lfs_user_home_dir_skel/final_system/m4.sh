#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "FINAL SYSTEM --- Building m4"

build_m4()
{
    ./configure --prefix=/usr
    make
    make check 2>&1 | tee /test_output/m4.txt
    make install
}


build_package m4 build_m4 skip_dedicated_build_dir
