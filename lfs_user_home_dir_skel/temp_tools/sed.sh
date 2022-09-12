#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building sed"


build_sed()
{
    ./configure --prefix=/usr   \
            --host=$LFS_TGT
    make
    make DESTDIR=$LFS install
}


build_package "^sed" build_sed skip_dedicated_build_dir
