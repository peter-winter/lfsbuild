#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -z "$LFS" ]
  then echo "LFS variable is blank"
  exit
fi

rm -vrf $LFS/*

mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools

if id -u lfs >/dev/null 2>&1
  then echo "lfs user exists"
  userdel -rf lfs
fi
groupadd lfs
useradd -s /bin/bash -g lfs -m -k ./lfs_user_home_dir_skel lfs
passwd lfs

chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac

sed -i "s:<<lfs_mount_dir>>:$LFS:g" /home/lfs/.bashrc

mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
wget -O $LFS/sources/md5sums https://www.linuxfromscratch.org/lfs/view/stable/md5sums
wget -O $LFS/sources/wget-list-sysv https://www.linuxfromscratch.org/lfs/view/stable/wget-list-sysv

wget --input-file=$LFS/sources/wget-list-sysv --continue --directory-prefix=$LFS/sources
pushd $LFS/sources
  md5sum -c md5sums
popd
