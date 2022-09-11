#! /bin/bash

source functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building ncurses"

ensure_gawk_and_build_tic()
{
    sed -i s/mawk// configure

    mkdir build
    pushd build
      ../configure
      make -C include
      make -C progs tic
    popd
}

build_ncurses()
{
    ./configure --prefix=/usr                \
        --host=$LFS_TGT              \
        --build=$(./config.guess)    \
        --mandir=/usr/share/man      \
        --with-manpage-format=normal \
        --with-shared                \
        --without-normal             \
        --with-cxx-shared            \
        --without-debug              \
        --without-ada                \
        --disable-stripping          \
        --enable-widec
    make
    make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
}

create_linker_script()
{
    echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so
}

build_package ncurses build_ncurses skip_dedicated_build_dir ensure_gawk_and_build_tic create_linker_script
