#!/bin/bash
set -e

# msmtp doesn't like it's config to be accessible to non-owners
chmod go-rwx /etc/msmtp.conf/msmtprc
chown www-data /etc/msmtp.conf/msmtprc

touch /var/log/msmtp.log
chgrp www-data /var/log/msmtp.log
chmod g+w /var/log/msmtp.log

rm -f "$APACHE_PID_FILE"
/usr/sbin/apache2 &
tail -f $APACHE_LOG_DIR/*
