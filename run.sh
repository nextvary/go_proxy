#!/bin/sh

if [ "${secret}" == "" ];then
  echo "需要secret 环境变量"
  exit
fi
if [ "${app}" == "" ];then
  app="cpolar_proxy"
  proxy="proxy"
fi

function run_cpolar(){
  echo "run_cpolar"

	ps -ef |grep cpolar: |grep -v 'grep' |awk '{print $1}' |xargs kill -9
	rm -rf ./log*
	./$app authtoken $secret &
	./$app tcp 9958 -log ./log --log-level INFO --daemon on &
	proxyAddr=$(get_url)
	echo $proxyAddr
	run_proxy $proxyAddr
}

function get_url(){
	sleep 4
	tcp=$(tail -20 ./log |grep 'Tunnel established' |cut -d " " -f 9|sed "s/\"//g")
	echo $tcp >>./log
	echo $tcp
}

function run_proxy() {
  ps -ef |grep 9958 |grep -v 'grep' |awk '{print $2}' |xargs kill -9
  nohup ./$proxy -m=proxy -p=0.0.0.0:9958 r=$1 >./log 2>&1 &
  ps -ef
  tail -100f ./log

}

run_cpolar
