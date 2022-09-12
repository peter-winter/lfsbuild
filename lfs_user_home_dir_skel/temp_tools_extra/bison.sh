#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "TEMPORARY TOOLS (EXTRA) --- Building bison"

build_bison()
{
    ./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.8.2
    make
    make install
}


build_package bison build_bison skip_dedicated_build_dir
