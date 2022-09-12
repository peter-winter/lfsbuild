#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building gawk"

assure_skip_unnecessary_files()
{
    sed -i 's/extras//' Makefile.in
}

build_gawk()
{
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
}


build_package gawk build_gawk skip_dedicated_build_dir assure_skip_unnecessary_files
