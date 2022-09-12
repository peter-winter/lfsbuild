#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building binutils, pass 2"

libtool_workaround()
{
    sed '6009s/$add_dir//' -i ltmain.sh
}

build_binutils_pass2()
{
    ../configure                   \
        --prefix=/usr              \
        --build=$(../config.guess) \
        --host=$LFS_TGT            \
        --disable-nls              \
        --enable-shared            \
        --enable-gprofng=no        \
        --disable-werror           \
        --enable-64-bit-bfd

    make
    make DESTDIR=$LFS install
}

remove_libtool_archives_and_static_libs()
{
    rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.{a,la}
}

build_package binutils build_binutils_pass2 "" libtool_workaround remove_libtool_archives_and_static_libs
