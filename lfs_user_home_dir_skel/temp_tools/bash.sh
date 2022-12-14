#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building bash"

build_bash()
{
    ./configure --prefix=/usr                   \
            --build=$(support/config.guess) \
            --host=$LFS_TGT                 \
            --without-bash-malloc
    make
    make DESTDIR=$LFS install
}

create_link()
{
    ln -sv bash $LFS/bin/sh
}

build_package bash build_bash skip_dedicated_build_dir "" create_link
