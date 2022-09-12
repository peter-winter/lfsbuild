#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building xz"


build_xz()
{
    ./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --disable-static                  \
            --docdir=/usr/share/doc/xz-5.2.6
    make
    make DESTDIR=$LFS install
}

remove_libtool_archives()
{
    rm -v $LFS/usr/lib/liblzma.la
}

build_package "^xz" build_xz skip_dedicated_build_dir "" remove_libtool_archives
