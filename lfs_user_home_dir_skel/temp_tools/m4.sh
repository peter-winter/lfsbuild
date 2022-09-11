#! /bin/bash

source functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building m4"

build_m4()
{
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
}

build_package m4 build_m4 skip_dedicated_build_dir
