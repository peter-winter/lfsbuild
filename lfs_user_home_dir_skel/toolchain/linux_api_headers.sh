#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TOOLCHAIN --- Building Linux API headers"

prepare()
{
    make mrproper
}

make_and_copy_headers()
{
    make headers
    find usr/include -type f ! -name '*.h' -delete
    cp -rv usr/include $LFS/usr
}

build_package "^linux" make_and_copy_headers skip_dedicated_build_dir prepare
