#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "TEMPORARY TOOLS (EXTRA) --- Building gettext"

build_gettext()
{
    ./configure --disable-shared
    make
    cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
}


build_package gettext build_gettext skip_dedicated_build_dir
