FROM debian:jessie

# DEBUG MODE
RUN apt-get update && \
    apt-get install -y vim less curl mysql-client-5.5 && \
    rm -rf /var/lib/apt/lists/*

# Install Apache

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 && \
    rm -rf /var/lib/apt/lists/*

# Install PHP

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y php5 php5-mysqlnd libapache2-mod-php5 php5-curl && \
    rm -rf /var/lib/apt/lists/*

# Install msmtp

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y msmtp msmtp-mta && \
    rm -rf /var/lib/apt/lists/*

# Begin Apache Configuration

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p /var/lock/apache2

COPY ./opt /opt/
COPY ./000-default.conf /etc/apache2/sites-available/

RUN a2dismod mpm_event && a2enmod mpm_prefork && a2enmod rewrite && a2enmod headers

# End Apache Configuration

# Begin PHP Configuration

RUN sed -E -i.bak \
      -e "s#;?sendmail_path.*\$#sendmail_path = \"/usr/bin/msmtp -C /etc/msmtp.conf/msmtprc -a mailgun -t\"#" /etc/php5/apache2/php.ini

# End PHP Configuration

# Install Brew Competition Online Entry & Management - Registration
COPY ./brewcompetitiononlineentry/ /var/www/registration/

WORKDIR /var/www/registration

RUN sed -E -i.bak \
      -e "s/\\\$(hostname|database_port|username|password) = .*;/\$\\1 = getenv(\"MYSQL_\\U\\1\\E\");/" \
      -e "s/\\\$database = .*;/\$database = getenv(\"MYSQL_DATABASE_REGISTRATION\");/" \
      -e "s/\\\$setup_free_access = .*;/\$setup_free_access = (getenv(\"SETUP_MODE\") === \"TRUE\");/" \
      -e "s/\\\$installation_id = \"\";/\$installation_id = getenv(\"INSTANCE_ID\") . \"_registration\" ;/" site/config.php

VOLUME /var/www/registration/ext

VOLUME /var/www/registration/user_images
VOLUME /var/www/registration/user_docs
VOLUME /var/www/registration/user_temp

# Install Brew Competition Online Entry & Management - Results2018
COPY ./brewcompetitiononlineentry/ /var/www/results2018/

WORKDIR /var/www/results2018

RUN sed -E -i.bak \
      -e "s/\\\$(hostname|database_port|username|password) = .*;/\$\\1 = getenv(\"MYSQL_\\U\\1\\E\");/" \
      -e "s/\\\$database = .*;/\$database = getenv(\"MYSQL_DATABASE_RESULTS2018\");/" \
      -e "s/\\\$setup_free_access = .*;/\$setup_free_access = (getenv(\"SETUP_MODE\") === \"TRUE\");/" \
      -e "s/\\\$installation_id = \"\";/\$installation_id = getenv(\"INSTANCE_ID\") . \"_results2018\" ;/" site/config.php

VOLUME /var/www/results2018/ext

VOLUME /var/www/results2018/user_images
VOLUME /var/www/results2018/user_docs
VOLUME /var/www/results2018/user_temp

# general use volumes

VOLUME /etc/msmtp.conf
VOLUME /var/log

WORKDIR /var/www/

EXPOSE 80
CMD ["/opt/bin/start-apache.sh"]
