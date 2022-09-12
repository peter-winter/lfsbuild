#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building grep"


build_grep()
{
    ./configure --prefix=/usr   \
            --host=$LFS_TGT
    make
    make DESTDIR=$LFS install
}


build_package grep build_grep skip_dedicated_build_dir
