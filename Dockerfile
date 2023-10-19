FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

#RUN apk add --no-cache tzdata ca-certificates && rm -rf /var/cache/apk/*

RUN mkdir -p /data/deploy

COPY .  /data/deploy

ENV TZ Asia/Shanghai

EXPOSE 9958


WORKDIR /data/deploy

ENTRYPOINT ["sh", "-c", "cat /data/deploy/run.sh && pwd && /data/deploy/run.sh"]

#docker run --rm -it -p 9958:9958 -e secret= -v ./run.sh:/data/deploy/run.sh  registry.cn-hangzhou.aliyuncs.com/vary/lnmp:go-proxy sh
#docker run --rm -it  -e secret= registry.cn-hangzhou.aliyuncs.com/vary/lnmp:go-proxy sh