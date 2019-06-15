#!/bin/bash
set -e

# msmtp doesn't like it's config to be accessible to non-owners
chmod go-rwx /etc/msmtp.conf/msmtprc
chown www-data /etc/msmtp.conf/msmtprc

# make msmtp logs accessible to www-data
touch /var/log/msmtp.log
chgrp www-data /var/log/msmtp.log
chmod g+w /var/log/msmtp.log

# make user_* data directories accessible to www-data
chgrp www-data /var/www/html/user_*
chmod g+w /var/www/html/user_*

rm -f "$APACHE_PID_FILE"
/usr/sbin/apache2 &
tail -f $APACHE_LOG_DIR/*
