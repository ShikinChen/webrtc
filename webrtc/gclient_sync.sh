#! /bin/bash
SHELL_PATH=$(pwd)
WEBRTC_PATH=${SHELL_PATH}

# Also support containers launched before both proxy variable forms were set.
export http_proxy="${http_proxy:-${HTTP_PROXY:-}}"
export https_proxy="${https_proxy:-${HTTPS_PROXY:-}}"

if [ -f "$WEBRTC_PATH/.boto" ]; then
  export NO_AUTH_BOTO_CONFIG=$WEBRTC_PATH/.boto
fi

MIRROR=$2
ARGS=""

if [ ! -n "$MIRROR" ]; then
  MIRROR=webrtc_android
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
    git config --global --add safe.directory /webrtc/depot_tools
    cd "$WEBRTC_PATH" || exit 1
    if [ -f .gclient ] && [ -z "$2" ]; then
      exec gclient sync --nohooks
    fi
    exec fetch --nohooks "$MIRROR"
  else
    cd ${WEBRTC_PATH} && gclient sync -v -f -D --with_branch_heads $ARGS
  fi
else
  cd ${WEBRTC_PATH} && gclient sync -v -f -D --with_branch_heads $ARGS
fi
