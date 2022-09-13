#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "FINAL SYSTEM --- Building xz"

build_xz()
{
    ./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.2.6
    make
    make check 2>&1 | tee /test_output/xz.txt
    make install
}

build_package "^xz" build_xz skip_dedicated_build_dir
