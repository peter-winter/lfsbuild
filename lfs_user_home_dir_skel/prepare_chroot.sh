#! /bin/bash

source functions.sh

root_guard
lfs_var_guard

cp -vrf /home/lfs/temp_tools_extra $LFS/tools
cp -vrf /home/lfs/final_system $LFS/tools
cp -vf /home/lfs/functions.sh $LFS/tools

chown -vR root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -vR root:root $LFS/lib64 ;;
esac

mkdir -pv $LFS/{dev,proc,sys,run}

mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run
if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
