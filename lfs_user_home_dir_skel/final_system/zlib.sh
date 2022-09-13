#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "FINAL SYSTEM --- Building zlib"

build_zlib()
{
    ./configure --prefix=/usr
    make
    make check 2>&1 | tee /test_output/zlib.txt
    make install
}

remove_static_lib()
{
    rm -fv /usr/lib/libz.a
}

build_package zlib build_zlib skip_dedicated_build_dir "" remove_static_lib
