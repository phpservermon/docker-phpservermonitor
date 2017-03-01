FROM eboraas/apache
MAINTAINER Ed Boraas <ed@boraas.ca>

RUN apt-get update && apt-get -y install php5 php5-mysql curl wget php5-curl && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork


CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
EXPOSE 443

ENV VERSION develop
ENV PHPMONITOR_URL https://github.com/phpservermon/phpservermon/archive/develop.zip

RUN set -x \
    && cd /var/www/html \
	&& rm -rf * \
	&& cd /tmp \
	&& wget $PHPMONITOR_URL \
	&& unzip develop.zip\
	&& cd phpservermon-develop \
  && rm phpservermon-develop \
	&& mv * /var/www/html \
	&& cd /var/www/html \
	&& touch config.php \
	&& chmod 0777 config.php
