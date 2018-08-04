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
    DEBIAN_FRONTEND=noninteractive apt-get install -y php5 php5-mysqlnd libapache2-mod-php5 && \
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

# Install Brew Competition Online Entry & Management
COPY ./brewcompetitiononlineentry/ /var/www/html/

# Deploy Local Customizations
COPY ./web/ext/*.php /var/www/html/

WORKDIR /var/www/html

RUN sed -E -i.bak \
      -e "s/\\\$(hostname|database_port|username|password|database) = .*;/\$\\1 = getenv(\"MYSQL_\\U\\1\\E\");/" \
      -e "s/\\\$instance_id = \"\";/\$instance_id = getenv(\"INSTANCE_ID\");/" site/config.php

VOLUME /var/log

EXPOSE 80
CMD ["/opt/bin/start-apache.sh"]
