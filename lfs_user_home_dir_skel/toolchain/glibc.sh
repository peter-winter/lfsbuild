#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

lfs_user_guard
lfs_var_guard

echo "TOOLCHAIN --- Building glibc"

create_symlinks_and_patch_sources()
{
    case $(uname -m) in
        i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
        ;;
        x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
                ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
        ;;
    esac

    patch -Np1 -i ../glibc-2.36-fhs-1.patch
}

build_glibc()
{
    echo "rootsbindir=/usr/sbin" > configparms

    ../configure                             \
          --prefix=/usr                      \
          --host=$LFS_TGT                    \
          --build=$(../scripts/config.guess) \
          --enable-kernel=3.2                \
          --with-headers=$LFS/usr/include    \
          libc_cv_slibdir=/usr/lib
    make
    make DESTDIR=$LFS install

    sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
}

finalize_limits_header()
{
    $LFS/tools/libexec/gcc/$LFS_TGT/12.2.0/install-tools/mkheaders
}

build_package "glibc*tar*" build_glibc "" create_symlinks_and_patch_sources finalize_limits_header
