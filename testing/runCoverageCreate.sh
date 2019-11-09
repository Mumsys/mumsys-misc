#!/bin/sh

# Mumsys project - misc tools

PROGRAM='phpunit';

echo "------------------------------------------";
echo "usage: $0 [phpunit options] <file or dir>";
echo "------------------------------------------";

# The directory of this file.
SCRIPT_DIR="$(dirname $(readlink -f "$0"))";

# source BASEDIR location
. ${SCRIPT_DIR}/source-env-file.sh

# check vendor program
. ${SCRIPT_DIR}/source-check-vendor-available.sh

# setup: $ ./phpunit --dump-xdebug-filter .../xdebug-filter.php
COVERAGE_SPEEDUP='';
if [ -f "${SCRIPT_DIR}/xdebug-filter.php" ]; then
    COVERAGE_SPEEDUP="--prepend ${SCRIPT_DIR}/xdebug-filter.php";
    echo "Using also: '${COVERAGE_SPEEDUP}'";
fi

${PHP_BIN} ${SCRIPT_DIR}/../../vendor/bin/${PROGRAM} --colors \
    --configuration ${SCRIPT_DIR}/../../tests/phpunit-coverage.xml \
    --bootstrap ${SCRIPT_DIR}/../../tests/bootstrap.php \
    ${COVERAGE_SPEEDUP} $*
