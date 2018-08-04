#!/bin/bash
set -e

rm -f "$APACHE_PID_FILE"
/usr/sbin/apache2 &
tail -f $APACHE_LOG_DIR/*
