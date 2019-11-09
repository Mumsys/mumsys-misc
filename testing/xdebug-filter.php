<?php declare(strict_types=1);

# Mumsys project - misc tools

if ( !\function_exists( 'xdebug_set_filter' ) ) {
    return;
}

// echo 'xdebug_set_filter: ' . __DIR__ . '/../../src/';

\xdebug_set_filter(
    \XDEBUG_FILTER_CODE_COVERAGE, \XDEBUG_PATH_WHITELIST,
    [
        __DIR__ . '/../../src/'
    ]
);
