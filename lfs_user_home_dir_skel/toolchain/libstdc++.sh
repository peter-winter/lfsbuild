#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TOOLCHAIN --- Building libstdc++"

build_libstdc++()
{
    ../libstdc++-v3/configure           \
        --host=$LFS_TGT                 \
        --build=$(../config.guess)      \
        --prefix=/usr                   \
        --disable-multilib              \
        --disable-nls                   \
        --disable-libstdcxx-pch         \
        --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/12.2.0
    make
    make DESTDIR=$LFS install
}

remove_libtool_archives()
{
    rm -v $LFS/usr/lib/lib{stdc++,stdc++fs,supc++}.la
}

build_package gcc build_libstdc++ "" "" remove_libtool_archives
