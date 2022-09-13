#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "FINAL SYSTEM --- Building file"

build_file()
{
    ./configure --prefix=/usr
    make check 2>&1 | tee /test_output/file.txt
    make install
}


build_package "file*tar*" build_file skip_dedicated_build_dir
