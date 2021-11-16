#!/bin/bash
SHELL_PATH=$(pwd)
WEBRTC_PATH=$SHELL_PATH
WEBRTC_SRC=$WEBRTC_PATH/src
WEBRTC_OUT=$WEBRTC_SRC/out

rm -rf ${WEBRTC_OUT}/mac

export PATH=$PATH:$WEBRTC_PATH/depot_tools

cd $WEBRTC_SRC&&gn gen ${WEBRTC_OUT}/mac --args='target_os="mac" target_cpu="x64" is_debug=true symbol_level=2 enable_dsyms=true' --ide=xcode

if [ ! -d "$WEBRTC_PATH/out" ]; then
  mkdir -p $WEBRTC_PATH/out
fi

WEBRTC_OUT_MAC=$WEBRTC_OUT/mac
WEBRTC_PATH_OUT=$WEBRTC_PATH/out

ln -f -s $WEBRTC_OUT_MAC $WEBRTC_PATH_OUT
