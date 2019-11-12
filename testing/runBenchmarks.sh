#!/bin/sh

# Mumsys project - misc tools

PROGRAM='phpbench';

echo "------------------------------------------";
echo "usage: $0 [phpbench options] <bench file or dir>";
echo "------------------------------------------";

# The directory of this file.
SCRIPT_DIR="$(dirname $(readlink -f "$0"))";

# source BASEDIR location
. ${SCRIPT_DIR}/source-env-file.sh

# check vendor program
. ${SCRIPT_DIR}/source-check-vendor-available.sh

# Use --store to save a run in logs/phpbench_history
# --store

if [ ! -f "${SCRIPT_DIR}/../../tests/phpbench.json" ] ; then
    PHP_BENCH_CONFIG="${SCRIPT_DIR}/phpbench.json-dist";
    echo "This may fail! Using ${PHP_BENCH_CONFIG}. Please setup this config or create a copy in ./tests";
else
    PHP_BENCH_CONFIG="${SCRIPT_DIR}/../../tests/phpbench.json";
fi

# make sure phpbench.json* file will be executed based on this path
cd "${SCRIPT_DIR}/../../tests";

echo '---';
echo "Cool down! This may take some time/hours when testing all.";
echo '---'

${PHP_BIN} ${SCRIPT_DIR}/../../vendor/bin/${PROGRAM} run \
    --report=aggregate \
    --bootstrap=${SCRIPT_DIR}/../../tests/bootstrap.php \
    --config=${PHP_BENCH_CONFIG} \
    "$*"
