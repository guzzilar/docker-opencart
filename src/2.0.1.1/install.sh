#!/bin/sh

###
# OpenCart 2.0.1.1 directory: /var/www/html/opencart-2.0.1.1
# Build directory:            /var/www/html/opencart-2.0.1.1/_build
###
cd ./opencart-2.0.1.1
rm -R ./_build
mkdir ./_build

# DEPLOY
git clone --branch 2.0.1.1 https://github.com/opencart/opencart.git
mv ./opencart/* ./_build/
rm -R ./opencart

mv ./_build/upload/config-dist.php ./_build/upload/config.php
mv ./_build/upload/admin/config-dist.php ./_build/upload/admin/config.php

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

rm -R ./_build/upload/install
rm ../opencart-2.0.1.1-install.sh

chown -R www-data:www-data .

apache2 -D FOREGROUND
