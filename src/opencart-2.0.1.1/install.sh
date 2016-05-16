#!/bin/sh

###
# OpenCart 2.0.1.1 directory: /var/www/html/opencart-2.0.1.1
# Build directory:            /var/www/html/opencart-2.0.1.1/_build
###
cd ./opencart-2.0.1.1
rm -R ./_build
mkdir ./_build

# DEPLOY
# curl -o opencart-2.0.1.1.zip https://codeload.github.com/opencart/opencart/zip/2.0.1.1
# unzip -q opencart-2.0.1.1.zip -d ./_build
# rm opencart-2.0.1.1.zip

# TEST
cp -R ./_resources/opencart/* ./_build/
# unzip -q ./_resources/opencart-2.0.1.1.zip -d ./_build

# mv ./_build/opencart-2.0.1.1/upload/* ./_build/.
mv ./_build/upload/config-dist.php ./_build/upload/config.php
mv ./_build/upload/admin/config-dist.php ./_build/upload/admin/config.php

# Do tricky tasks
# mv ./_build/install/cli_install.php ./_build/install/cli_install.php.bak
# cp cli_install.template.php ./_build/install/cli_install.php

# Do install
cd ./_build/upload/install
php cli_install.php install --db_driver mysqli \
                            --db_hostname opencart2011_db \
                            --db_username root \
                            --db_password root \
                            --db_database opencart2011_db \
                            --db_prefix oc_ \
                            --username admin \
                            --password admin \
                            --email iam.nuttanon@gmail.com \
                            --http_server http://192.168.99.100/opencart-2.0.1.1/_build/upload/

cd ../../../

# rm -R ./_build/install
# rm -R ./_build/opencart-2.0.1.1
rm ../opencart-2.0.1.1-install.sh

chown -R www-data:www-data .

cd ./_build/tests/phpunit
composer update
./vendor/bin/phpunit --bootstrap bootstrap.php opencart/admin

apache2 -D FOREGROUND
