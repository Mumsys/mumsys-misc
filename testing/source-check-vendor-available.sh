#!/bin/sh

# Mumsys project - misc tools

# check init program, requires a 'vendor/bin/' executable, SCRIPT_DIR, PROGRAM

if [ ! -f "${SCRIPT_DIR}/../../vendor/bin/${PROGRAM}" ];
then
    echo "vendor/bin/${PROGRAM} not available";
    exit 1;
fi
