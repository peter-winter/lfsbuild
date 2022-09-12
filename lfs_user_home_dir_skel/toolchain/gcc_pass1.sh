#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TOOLCHAIN --- Building gcc, pass 1"

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
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
     ;;
    esac
}

build_gcc_pass1()
{
    ../configure                  \
        --target=$LFS_TGT         \
        --prefix=$LFS/tools       \
        --with-glibc-version=2.36 \
        --with-sysroot=$LFS       \
        --with-newlib             \
        --without-headers         \
        --disable-nls             \
        --disable-shared          \
        --disable-multilib        \
        --disable-decimal-float   \
        --disable-threads         \
        --disable-libatomic       \
        --disable-libgomp         \
        --disable-libquadmath     \
        --disable-libssp          \
        --disable-libvtv          \
        --disable-libstdcxx       \
        --enable-languages=c,c++
    make
    make install
}

create_limits_header()
{
    cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
        `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
}

build_package gcc build_gcc_pass1 "" prepare_gcc_sources create_limits_header
