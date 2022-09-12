#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "TEMPORARY TOOLS (EXTRA) --- Building python"

build_python()
{
    ./configure --prefix=/usr   \
            --enable-shared \
            --without-ensurepip
    make
    make install
}


build_package Python build_python skip_dedicated_build_dir
