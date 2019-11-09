#!/bin/sh

# Mumsys project - misc tools

# source BASEDIR, PHP_BIN, PHP_PHING ... locations

if [ "${SCRIPT_DIR}" = "" ]; then
    echo" SCRIPT_DIR not set";
    exit 1;
fi

if [ -f "${SCRIPT_DIR}/../../.env" ]; then
    . "${SCRIPT_DIR}/../../.env";
else
    echo "WARNING";
    echo "Source default .env-dist please setup the ".env" file !!!";
    . "${SCRIPT_DIR}/../../.env-dist";
    BASEDIR="${SCRIPT_DIR}/../..";
fi
