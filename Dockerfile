FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache tzdata ca-certificates && rm -rf /var/cache/apk/*

RUN mkdir -p /data/deploy

COPY .  /data/deploy

ENV TZ Asia/Shanghai

EXPOSE ${PORT}


WORKDIR /data/deploy

CMD ["sh", "-c", "./go_proxy -m=proxy -p=0.0.0.0:${PROT}"]
