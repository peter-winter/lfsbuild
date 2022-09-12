#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TEMPORARY TOOLS --- Building gcc, pass 2"

prepare_gcc_sources()
{
    tar -xf ../mpfr-4.1.0.tar.xz
    mv -v mpfr-4.1.0 mpfr
    tar -xf ../gmp-6.2.1.tar.xz
    mv -v gmp-6.2.1 gmp
    tar -xf ../mpc-1.2.1.tar.gz
    mv -v mpc-1.2.1 mpc

    case $(uname -m) in
      x86_64)
        sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
      ;;
    esac

    sed '/thread_header =/s/@.*@/gthr-posix.h/' \
    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in
}

build_gcc_pass2()
{
    ../configure                                       \
        --build=$(../config.guess)                     \
        --host=$LFS_TGT                                \
        --target=$LFS_TGT                              \
        LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc      \
        --prefix=/usr                                  \
        --with-build-sysroot=$LFS                      \
        --enable-initfini-array                        \
        --disable-nls                                  \
        --disable-multilib                             \
        --disable-decimal-float                        \
        --disable-libatomic                            \
        --disable-libgomp                              \
        --disable-libquadmath                          \
        --disable-libssp                               \
        --disable-libvtv                               \
        --enable-languages=c,c++
    make
    make DESTDIR=$LFS install
}

create_link()
{
    ln -sv gcc $LFS/usr/bin/cc
}

build_package gcc build_gcc_pass2 "" prepare_gcc_sources create_link
