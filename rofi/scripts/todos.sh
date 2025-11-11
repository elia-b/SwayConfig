#!/usr/bin/env bash

if [[ -z $1 ]]; then
    doit
else
    echo $1 | wl-copy
fi
