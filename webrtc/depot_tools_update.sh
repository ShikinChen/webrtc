#! /bin/sh
SHELL_PATH=$(pwd)
MIRROR=$1

if [ ! -n "$MIRROR" ]; then
    MIRROR=agoralab
fi
WEBRTC_SRC=$SHELL_PATH/webrtc_src/${MIRROR}

cd $WEBRTC_SRC/depot_tools&&git pull
