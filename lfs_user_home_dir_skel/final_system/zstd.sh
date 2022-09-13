#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "FINAL SYSTEM --- Building zstd"

apply_patch()
{
    patch -Np1 -i ../zstd-1.5.2-upstream_fixes-1.patch
}

build_zstd()
{
    make prefix=/usr
    make check 2>&1 | tee /test_output/zstd.txt
    make prefix=/usr install
}

remove_static_lib()
{
    rm -v /usr/lib/libzstd.a
}

build_package "zstd*tar*" build_zstd skip_dedicated_build_dir apply_patch remove_static_lib
