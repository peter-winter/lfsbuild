#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "FINAL SYSTEM --- Building man pages"

install_manpages()
{
    make prefix=/usr install
}


build_package man-pages install_manpages skip_dedicated_build_dir
