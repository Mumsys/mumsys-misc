#!/bin/sh

# Mumsys project - misc tools

PROGRAM='phpcs';

echo "----------------------------------------";
echo "usage: $0 [phpcs options] <path or file>";
echo "----------------------------------------";

# The directory of this file.
SCRIPT_DIR="$(dirname $(readlink -f "$0"))";

# source BASEDIR location
. ${SCRIPT_DIR}/source-env-file.sh

# check vendor program
. ${SCRIPT_DIR}/source-check-vendor-available.sh

. "${SCRIPT_DIR}/phpcs-base.sh";
CS_BIN="${SCRIPT_DIR}/../../vendor/bin/phpcs";

${PHP_BIN} ${CS_BIN} ${PHPCS_STANDARD} ${PHPCS_IGNORELINE} $*

echo "--------------------------------------------------------------------------------";
echo "Give maximum attention to ERRORS try to fix WARNINGS!";
echo "--------------------------------------------------------------------------------";
