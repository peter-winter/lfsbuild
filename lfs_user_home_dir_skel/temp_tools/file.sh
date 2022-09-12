#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building file"

prepare_host_file_app()
{
    mkdir build
    pushd build
      ../configure --disable-bzlib      \
                   --disable-libseccomp \
                   --disable-xzlib      \
                   --disable-zlib
      make
    popd
}

build_file()
{
    ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)
    make FILE_COMPILE=$(pwd)/build/src/file
    make DESTDIR=$LFS install
}

remove_libtool_archive()
{
    rm -v $LFS/usr/lib/libmagic.la
}

build_package file build_file skip_dedicated_build_dir prepare_host_file_app remove_libtool_archive
