#! /bin/bash
SHELL_PATH=$(pwd)


MIRROR=$1

OS=`uname -s`
SED_REPLACE="sed -i"
if [ ${OS} == "Darwin"  ];then
  SED_REPLACE="${SED_REPLACE} _bak"
fi

if [ ! -n "$MIRROR" ]; then
    MIRROR=agoralab
fi

WEBRTC_SRC=$SHELL_PATH/webrtc_src/${MIRROR}

if [ ! -d "$WEBRTC_SRC" ]; then
  mkdir -p $WEBRTC_SRC
fi

cp "$SHELL_PATH/gclient_sync.sh" "$WEBRTC_SRC/gclient_sync.sh"

cp "$SHELL_PATH/gclient.txt" "$WEBRTC_SRC/.gclient"
cp "$SHELL_PATH/generate_mac_ide.sh" "$WEBRTC_SRC/generate_mac_ide.sh"
cp "$SHELL_PATH/build_android.sh" "$WEBRTC_SRC/build_android.sh"
cp "$SHELL_PATH/CMakeLists.txt" "$WEBRTC_SRC/CMakeLists.txt"

GCLIENT_FILE=${WEBRTC_SRC}/.gclient

if [ -f $GCLIENT_FILE ]; then
    if [ "$MIRROR" == "agoralab" ]; then
        ${SED_REPLACE} 's/https:\/\/webrtc.googlesource.com\/src.git/https:\/\/webrtc.bj2.agoralab.co\/webrtc-mirror\/src.git@65e8d9facab05de13634d777702b2c93288f8849/g' ${GCLIENT_FILE} 
    fi
fi

if [ ! -d $WEBRTC_SRC/depot_tools ]; then
  if [ "$MIRROR" == "agoralab" ]; then
    git clone https://webrtc.bj2.agoralab.co/webrtc-mirror/depot_tools.git $WEBRTC_SRC/depot_tools
  else
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git $WEBRTC_SRC/depot_tools
  fi
fi