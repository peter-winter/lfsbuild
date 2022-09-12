#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/functions.sh

root_guard

rm -rf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete

cp -vrf /tools/{final_system,functions.sh} /root
rm -rf /tools/*
mv -vf /root/{final_system,functions.sh} /tools
