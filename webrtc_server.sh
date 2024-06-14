#! /bin/sh
SHELL_PATH=$(pwd)

OS_TYPE=$(uname)

HOST_IP=$(ifconfig | grep inet | grep -v inet6 | grep -v 127 | cut -d ' ' -f2)

if [ "$OS_TYPE" = "Linux" ]; then
  HOST_IP=$(ifconfig | grep 'inet ' | grep -v 127 | awk '{print $2}')
fi

HOST_IP=($HOST_IP)
HOST_IP=${HOST_IP[0]}

echo "HOST_IP:${HOST_IP}"

docker run --name apprtc-server --rm -p 8080:8080 -p 8089:8089 -p 3033:3033  -p 3478:3478 -p 3478:3478/udp -e PUBLIC_IP=$HOST_IP  -it piasy/apprtc-server
