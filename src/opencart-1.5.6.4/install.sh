#!/bin/sh

###
# OpenCart 1.5.6.4 directory: /var/www/html/opencart-1.5.6.4
# Build directory:            /var/www/html/opencart-1.5.6.4/_build
###
cd ./opencart-1.5.6.4
rm -R ./_build
mkdir ./_build

# DEPLOY
curl -o opencart-1.5.6.4.zip https://codeload.github.com/opencart/opencart/zip/1.5.6.4
unzip -q opencart-1.5.6.4.zip -d ./_build
rm opencart-1.5.6.4.zip

# TEST
# unzip -q ./_resources/opencart-1.5.6.4.zip -d ./_build

mv ./_build/opencart-1.5.6.4/upload/* ./_build/.
mv ./_build/config-dist.php ./_build/config.php
mv ./_build/admin/config-dist.php ./_build/admin/config.php

# Do tricky tasks
mv ./_build/install/cli_install.php ./_build/install/cli_install.php.bak
cp cli_install.template.php ./_build/install/cli_install.php

# Do install
cd ./_build/install
php cli_install.php install --db_driver mysqli \
                            --db_host opencart1564_db \
                            --db_user root \
                            --db_password root \
                            --db_name opencart1564_db \
                            --db_prefix oc_ \
                            --username admin \
                            --password admin \
                            --email iam.nuttanon@gmail.com \
                            --agree_tnc yes \
                            --http_server http://192.168.99.100/opencart-1.5.6.4/_build/

cd ../../

rm -R ./_build/install
rm -R ./_build/opencart-1.5.6.4
rm ../opencart-1.5.6.4-install.sh

chown -R www-data:www-data .

apache2 -D FOREGROUND
