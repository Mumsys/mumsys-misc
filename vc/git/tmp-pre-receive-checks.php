#!/usr/bin/env php7.3
<?php

// see: http://criticallog.thornet.net/2011/06/02/running-php-linter-before-pushing-changes-to-a-git-repository/

echo "\nRunning checks...\n";

//
// --- actions/ functions ---------------------------------------------
//

/**
 * Run php -l to check lint errors in php scripts.
 *
 * @param string $content File contents
 *
 * @return int Returns the termination status of the process that was run. In case of an
 * error then -1 is returned.
 */
function phplint( $content )
{
    $descriptors = array(
        0 => array('pipe', 'r'),
        1 => array('pipe', 'w'),
        2 => array(
            'file', '/tmp/pre-receive-check.log', 'a'
            ),
    );
    $pipes = array();
    $cwd = '/tmp';
    $env = array('some_option' => 'aeiou');
    $proc = proc_open( 'php7.3 -l', $descriptors, $pipes, $cwd, $env );

    if ( !is_resource( $proc ) || $proc === false ) {
        echo "Could not creater php linter process\n\n";

        exit( 1 );
    }

    fwrite( $pipes[0], $content );
    fclose( $pipes[0] );

    $result = stream_get_contents( $pipes[1] );
    fclose( $pipes[1] );

    return proc_close( $proc );
}

//
// --- /actions/ functions --------------------------------------------
//

//
// --- start running --------------------------------------------------
//

$params = explode(' ', file_get_contents('php://stdin'));
$ref = trim($params[1]);

$diff = array();
$return = 0;

exec( "git diff --name-only $params[0] $params[1] 2> /dev/null", $diff, $return );

if ( $return > 0 ) {
    echo "Could not run git diff\n\n";

    exit( 1 );
}

$filenamePatternHooks = array(
    'php' => '/\.php$/'
);

foreach ( $filenamePatternHooks as $hook => $regex ) {

    foreach ( $diff as $file ) {

        echo "File: '$file'\n";

        if ( !preg_match( $regex, $file ) ) {
            continue;
        }

        $resultCode = 0;

        $treeRaw = '';
        $return = 0;
        exec( "git ls-tree $ref $file 2> /dev/null", $treeRaw, $return );
        if ( $return > 0 || empty( $treeRaw ) ) {

            echo "Could not run git ls-tree\n\n";
            exit( 1 );
        }
        $tree = preg_split( '/\s/', $treeRaw[0] );

        $fileContentsRaw = '';
        exec( "git cat-file $tree[1] $tree[2]  2> /dev/null", $fileContentsRaw, $return );
        if ( $return > 0 ) {
            echo "Could not run git cat-file\n\n";

            exit( 1 );
        }
        $fileContents = implode( "\n", $fileContentsRaw );

        switch ( $hook ) {

            case 'php':
                if ( $fileContents ) {
                    $codeA = phplint( $fileContents );
                    $resultCode = $codeA;
                }

                break;
        }

        if ( $resultCode != 0 ) {
            echo "Error parsing file '$file'\n\n";

            exit( $resultCode );
        }
    }

}

echo "No errors detected\n\n";
exit( 0 );
