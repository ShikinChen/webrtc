#! /bin/bash
SHELL_PATH=$(pwd)
WEBRTC_PATH=${SHELL_PATH}

if [ -f "$WEBRTC_PATH/.boto" ]; then
  export NO_AUTH_BOTO_CONFIG=$WEBRTC_PATH/.boto
fi

MIRROR=$2
ARGS=""

if [ ! -n "$MIRROR" ]; then
  MIRROR=agoralabx
fi

if [ "$MIRROR" == "agoralab" ]; then
  echo ""
  # cd /webrtc && gclient config --name src https://webrtc.bj2.agoralab.co/webrtc-mirror/src.git@65e8d9facab05de13634d777702b2c93288f8849
  # ARGS="--patch-ref=https://chromium.googlesource.com/chromium/src/build.git@gitlab"
fi

export PATH=$PATH:$WEBRTC_PATH/depot_tools

rm -rf $WEBRTC_PATH/src/third_party/llvm-build

if [ -n "$1" ]; then
  if [ $1 = "clean" ]; then
    BUILD_PATH=$WEBRTC_PATH/src/build
    if [ -d "$BUILD_PATH" ]; then
      rm -rf $BUILD_PATH
    fi

    THIRD_PARTY_PATH=$WEBRTC_PATH/src/third_party
    if [ -d "$THIRD_PARTY_PATH" ]; then
      rm -rf $THIRD_PARTY_PATH
    fi
  fi
  if [ $1 = "init" ]; then
    cd ${WEBRTC_PATH} && fetch --nohooks --with_branch_heads $MIRROR
  else
    cd ${WEBRTC_PATH} && gclient sync -v -f -D --with_branch_heads $ARGS
  fi
else
  cd ${WEBRTC_PATH} && gclient sync -v -f -D --with_branch_heads $ARGS
fi
