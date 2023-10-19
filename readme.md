/data/deploy/proxxy -m=proxy -p=0.0.0.0:9958


docker run --rm -it -p 9958:9958 -e secret=$secret -v /Users/renfei/work/gocode/gopath/src/nextvary.com/go_proxy/deploy/run.sh:/data/deploy/run.sh  registry.cn-hangzhou.aliyuncs.com/vary/lnmp:go-proxy sh
#docker run --rm -it  -e secret= registry.cn-hangzhou.aliyuncs.com/vary/lnmp:go-proxy sh