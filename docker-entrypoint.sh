#!/bin/sh
set -e

# Setup Database Connection
if [ ${PSM_AUTO_CONFIGURE} = true ]; then

# Setup / Create 
echo "Auto Configure / Create config.php"
touch ${APACHE_DOCUMENT_ROOT}/config.php; \
chmod 0777 ${APACHE_DOCUMENT_ROOT}/config.php

cat > ${APACHE_DOCUMENT_ROOT}/config.php << EOF
<?php
define('PSM_DB_HOST', '${MYSQL_HOST}');
define('PSM_DB_PORT', '');
define('PSM_DB_USER', '${MYSQL_USER}');
define('PSM_DB_PASS', '${MYSQL_PASSWORD}');
define('PSM_DB_NAME', '${MYSQL_DATABASE}');
define('PSM_DB_PREFIX', '${MYSQL_DATABASE_PREFIX}');
?>
EOF

else
# Setup Database Connection Defaults
echo "Setting Database Connection Defaults"
sed -ri -e "/db_host/s/'[^']*'/'${MYSQL_HOST}'/2" "${APACHE_DOCUMENT_ROOT}/src/psm/Module/Install/Controller/InstallController.php"
sed -ri -e "/db_port/s/'[^']*'/''/2" "${APACHE_DOCUMENT_ROOT}/src/psm/Module/Install/Controller/InstallController.php"
sed -ri -e "/db_name/s/'[^']*'/'${MYSQL_DATABASE}'/2" "${APACHE_DOCUMENT_ROOT}/src/psm/Module/Install/Controller/InstallController.php"
sed -ri -e "/db_user/s/'[^']*'/'${MYSQL_USER}'/2" "${APACHE_DOCUMENT_ROOT}/src/psm/Module/Install/Controller/InstallController.php"
sed -ri -e "/db_pass/s/'[^']*'/'${MYSQL_PASSWORD}'/2" "${APACHE_DOCUMENT_ROOT}/src/psm/Module/Install/Controller/InstallController.php"
sed -ri -e "/db_prefix/s/'[^']*'/'${MYSQL_DATABASE_PREFIX}'/2" "${APACHE_DOCUMENT_ROOT}/src/psm/Module/Install/Controller/InstallController.php"

fi

# Setup Database Connection
if [ ${PSM_PHP_DEBUG} = true ]; then

# PHP Debugging
cat > ${APACHE_DOCUMENT_ROOT}/phpinfo.php << EOF
<?php echo exec('whoami'); ?>
<?php
ini_set('display_errors',1);
error_reporting(E_ALL|E_STRICT);
ini_set('error_log','script_errors.log');
ini_set('log_errors','On');
phpinfo();
?>
EOF

fi

# wait until mariadb is ready
echo "Waiting until database is ready..."
/usr/local/bin/maria-wait.sh

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- apache2-foreground "$@"
fi

# Start CMD Commands
exec "$@" & (while true; do sleep "${PSM_REFRESH_RATE_SECONDS}"; /usr/local/bin/php ${APACHE_DOCUMENT_ROOT}/cron/status.cron.php; done)
#exec "$@" & (while true; do sleep ${PSM_REFRESH_RATE_SECONDS}; su -l www-data -s /usr/local/bin/php ${APACHE_DOCUMENT_ROOT}/cron/status.cron.php; done)
