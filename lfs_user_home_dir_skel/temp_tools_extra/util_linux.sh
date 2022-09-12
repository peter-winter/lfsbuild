#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "TEMPORARY TOOLS (EXTRA) --- Building util-linux"

create_hwclock_dir()
{
    mkdir -pv /var/lib/hwclock
}

build_util_linux()
{
    ./configure ADJTIME_PATH=/var/lib/hwclock/adjtime    \
            --libdir=/usr/lib    \
            --docdir=/usr/share/doc/util-linux-2.38.1 \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            runstatedir=/run
    make
    make install
}


build_package util-linux build_util_linux skip_dedicated_build_dir create_hwclock_dir
