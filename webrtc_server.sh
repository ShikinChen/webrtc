#! /bin/sh
SHELL_PATH=$(pwd)

HOST_IP=$(ifconfig | grep inet | grep -v inet6 | grep -v 127 | cut -d ' ' -f2)
HOST_IP=($HOST_IP)
HOST_IP=${HOST_IP[0]}

docker run --rm -p 8080:8080 -p 8089:8089 -p 3033:3033  -p 3478:3478 -p 3478:3478/udp -e PUBLIC_IP=$HOST_IP  -it piasy/apprtc-server
