#! /bin/bash

source functions.sh

lfs_user_guard
lfs_var_guard

echo "TOOLCHAIN --- Building binutils, pass 1"

build_binutils_pass1()
{
    ../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT   \
             --disable-nls       \
             --enable-gprofng=no \
             --disable-werror

    make
    make install
}

build_package binutils build_binutils_pass1
