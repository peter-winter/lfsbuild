#! /bin/bash

lfs_user_guard()
{
    if [ $(whoami) != "lfs" ]
      then echo "Please run as lfs"
      exit
    fi
}

lfs_var_guard()
{
    if [ -z "$LFS" ]
      then echo "LFS variable is blank"
      exit
    fi
}

build_package()
{
    pushd $LFS/sources

    TARBALL=$(ls | grep $1)

    echo "tarball = $TARBALL"

    tar -xf $TARBALL

    TARBALL_BASENAME=$(basename -- "$TARBALL")
    UNTARRED_DIR="${TARBALL_BASENAME%.tar.*}"

    echo "untarred dir = $UNTARRED_DIR"

    pushd $UNTARRED_DIR

    $4

    if [ "$3" != "skip_dedicated_build_dir" ]
      then mkdir -v build
      pushd build
    fi

    $2

    if [ "$3" != "skip_dedicated_build_dir" ]
      then popd
      rm -rf build
    fi

    $5

    popd
    rm -rf $UNTARRED_DIR
    popd
}
