#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../functions.sh

root_guard

echo "FINAL SYSTEM --- Building iana-etc"

install_iana_etc()
{
    cp services protocols /etc
}


build_package iana-etc install_iana_etc skip_dedicated_build_dir
