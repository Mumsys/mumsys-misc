#!/bin/bash

SCRIPT_DIR="$(dirname $(readlink -f "$0"))";

cd ${SCRIPT_DIR}/../../;

allversions='';

for PHPBIN in php5.6 php7.0 php7.1 php7.2 php7.3 php7.4 php8.0;
do
    if [ -f "`which ${PHPBIN}`" ]; then
        allversions="${allversions} ${PHPBIN}"
        echo
        echo "+----------------------------------------------------------";
        echo "| Found: $PHPBIN install deps...";
        ${PHPBIN} `which composer.phar` update --no-interaction --prefer-source --quiet

        echo "| Run tests (using $PHPBIN) ...";
        $PHPBIN ./vendor/bin/phpunit -c ./tests/phpunit.xml; # --coverage-text;
    fi
done;

echo "+----------------------------------------------------------";
echo "| Used PHP Versions:${allversions}";
echo "|                                                          ";
echo "| Your composer.lock file may has changed! Please checkout:";
echo "|     git checkout composer.lock                           ";
echo "| to have the defaults by the maintainer back again.       ";
echo "+----------------------------------------------------------";
