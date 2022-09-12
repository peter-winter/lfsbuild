#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "TEMPORARY TOOLS (EXTRA) --- Building texinfo"

build_texinfo()
{
    ./configure --prefix=/usr
    make
    make install
}


build_package texinfo build_texinfo skip_dedicated_build_dir
