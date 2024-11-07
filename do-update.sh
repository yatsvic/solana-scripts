#!/bin/bash

if [ $# -eq 0 ]; then
 echo "no version provided"
 exit 1
fi

agave-install init ${1}

