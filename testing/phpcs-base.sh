#!/bin/sh

# Mumsys project - misc tools

# squizlabs/php_codesniffer/CodeSniffer/Standards/
PHPCS_STANDARD="--standard=${SCRIPT_DIR}/../../misc/coding/Mumsys"
PHPCS_IGNORELINE='--ignore=data/*,vendor/*,helper/*,tmp/*,misc/*'
