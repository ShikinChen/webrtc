#! /bin/sh
SHELL_PATH=$(pwd)

MIRROR=$1
IS_PROXY=$2

PROXY_PORT=8118

if [ ! -n "$MIRROR" ]; then
    # MIRROR=agoralab
    MIRROR=google
fi

$SHELL_PATH/webrtc_gclient_sync_init.sh $MIRROR

WEBRTC_SRC=$SHELL_PATH/webrtc_src/$MIRROR

if [ ! -d "$WEBRTC_SRC" ]; then
  mkdir $WEBRTC_SRC
fi

# if [ ! -f "$WEBRTC_SRC/gclient_sync.sh" ]; then
#   cp "$SHELL_PATH/gclient_sync.sh" "$WEBRTC_SRC/gclient_sync.sh"
# fi
# if [ ! -f "$WEBRTC_SRC/depot_tools_update.sh" ]; then
#   cp "$SHELL_PATH/depot_tools_update.sh" "$WEBRTC_SRC/depot_tools_update.sh"
# fi

OS_TYPE=$(uname)

HOST_IP=$(ifconfig | grep inet | grep -v inet6 | grep -v 127 | cut -d ' ' -f2)

if [ "$OS_TYPE" = "Linux" ]; then
  HOST_IP=$(ifconfig | grep 'inet ' | grep -v 127 | awk '{print $2}')
fi


HOST_IP=($HOST_IP)
HOST_IP=${HOST_IP[0]}

BOTO="[Boto]
proxy = ${HOST_IP}
proxy_port = ${PROXY_PORT}"

if [ -f "$WEBRTC_SRC/.boto" ]; then
  rm "$WEBRTC_SRC/.boto"
fi

PROXY_SET="--env HTTP_PROXY=http://$HOST_IP:${PROXY_PORT} --env HTTPS_PROXY=http://$HOST_IP:${PROXY_PORT} --dns=8.8.8.8 --dns=8.8.4.4"

if [ -n "$IS_PROXY" ]; then
  if [ $IS_PROXY = "proxy-off" ]; then
    echo "proxy-off"
    PROXY_SET="--dns=8.8.8.8 --dns=8.8.4.4"
  else
    echo "proxy-on"
    if [ "$MIRROR" != "agoralab" ]; then
      echo $BOTO >> "$WEBRTC_SRC/.boto"
    fi
  fi
else
  echo "proxy-on"
  if [ "$MIRROR" != "agoralab" ]; then
    echo $BOTO >> "$WEBRTC_SRC/.boto"
  fi
fi
docker run --rm $PROXY_SET -v "$WEBRTC_SRC":/webrtc:cached -it webrtc_build
