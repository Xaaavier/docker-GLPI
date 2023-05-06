FROM alpine:3.17

LABEL Author="Xavier <xfrancois@gmx.fr>"
LABEL Maintaner="Xavier"
LABEL Release-date="2023-04-15"
LABEL Description="Dockerfile allowing a fast installation of a mariadb-server intended for the implementation of GLPI"
LABEL Version="1.0"

RUN apk update \
  && apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen tzdata \
  && rm -rf /tmp/*

ADD ./config/init.sh /scripts/init.sh

RUN mkdir /docker-entrypoint-initdb.d && \
  mkdir /scripts/pre-exec.d && \
  mkdir /scripts/pre-init.d && \
  chmod -R 755 /scripts 

EXPOSE 3306

CMD ["/scripts/init.sh"]