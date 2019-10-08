FROM postgres:12-alpine

WORKDIR /backups

RUN apk update && \
    apk upgrade && \
    apk add -U --no-cache tzdata bash gzip

RUN apk add -U --no-cache -X \
    http://dl-cdn.alpinelinux.org/alpine/edge/testing aws-cli

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone

COPY ./backup.sh /backups/.

RUN chmod +x /backups/backup.sh

CMD bash -c /backups/backup.sh
