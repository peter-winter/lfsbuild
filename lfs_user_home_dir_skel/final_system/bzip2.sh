#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "FINAL SYSTEM --- Building bzip2"

apply_patches()
{
    patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch
    sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
    sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
}

build_bzip2()
{
    make -f Makefile-libbz2_so
    make clean
    make 2>&1 | tee /test_output/bzip2.txt
    make PREFIX=/usr install
    cp -av libbz2.so.* /usr/lib
    ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so
    cp -v bzip2-shared /usr/bin/bzip2
    for i in /usr/bin/{bzcat,bunzip2}; do
      ln -sfv bzip2 $i
    done
}

remove_static_lib()
{
    rm -fv /usr/lib/libbz2.a
}

build_package "bzip2*.tar*" build_bzip2 skip_dedicated_build_dir apply_patches remove_static_lib
