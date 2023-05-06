FROM redis:alpine3.17

LABEL Author="Xavier <xfrancois@gmx.fr>"
LABEL Maintaner="Xavier"
LABEL Release-date="2023-04-15"
LABEL Description="Dockerfile allowing a fast installation of a nging intended for the implementation of GLPI"
LABEL Version="1.0"

RUN apk update \
  && apk add --no-cache tzdata \
  && rm -rf /tmp/*

COPY ./config/redis.conf /usr/local/etc/redis/redis.conf

EXPOSE 6379

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]