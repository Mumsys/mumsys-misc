#!/bin/sh

# Mumsys project - misc tools

PROGRAM='phpunit';

echo "------------------------------------------";
echo "usage: $0 [${PROGRAM} options] <file or dir>";
echo "------------------------------------------";

# The directory of this file.
SCRIPT_DIR="$(dirname $(readlink -f "$0"))";

# source BASEDIR location
. ${SCRIPT_DIR}/source-env-file.sh

# check vendor program
. ${SCRIPT_DIR}/source-check-vendor-available.sh

${PHP_BIN} ${SCRIPT_DIR}/../../vendor/bin/${PROGRAM} --colors \
    --configuration ${SCRIPT_DIR}/../../tests/phpunit.xml \
    --bootstrap ${SCRIPT_DIR}/../../tests/bootstrap.php \
    --no-coverage $*
