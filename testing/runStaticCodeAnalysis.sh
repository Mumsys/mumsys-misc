#!/bin/sh

# Mumsys project - misc tools

# Introduction (pro/cons) from 
# https://talks.benjamin-cremer.de/phpugms_sca/#/

PROGRAM='phpstan';

# The directory of this file.
SCRIPT_DIR="$(dirname $(readlink -f "$0"))";

# source BASEDIR location
. ${SCRIPT_DIR}/source-env-file.sh

# check vendor program
. ${SCRIPT_DIR}/source-check-vendor-available.sh

if [ "$1" = "--help" ] ; then
    echo "runs: ${PROGRAM} analyse <options> < path | file >";
fi

${PHP_BIN} ${SCRIPT_DIR}/../../vendor/bin/${PROGRAM} analyse $*
