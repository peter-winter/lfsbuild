#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building patch"


build_patch()
{
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
}


build_package "^patch" build_patch skip_dedicated_build_dir
