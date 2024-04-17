#!/bin/bash
SHELL_PATH=$(pwd)
SRC_PATH=$SHELL_PATH/src
OUT_PATH=$SRC_PATH/out/android_debug
ANDROID_BUILD_PATH=$SRC_PATH/build/toolchain/android/BUILD.gn

export PATH=$PATH:$SHELL_PATH/depot_tools

abi=arm64-v8a

if [ -n "$1" ]; then
  abi=$1
fi

if [ ! -d "$OUT_PATH" ]; then
  mkdir -p $OUT_PATH
fi

if [ ! -f "${ANDROID_BUILD_PATH}_bak" ]; then
  cp $ANDROID_BUILD_PATH ${ANDROID_BUILD_PATH}_bak
fi

BRANCH=$(cd $SRC_PATH && git status | grep "branch-heads" | awk -F '/' '{print $2}' | awk -F "'" '{print $1}')

MIN_BRANCH=4664

sed -i "/strip = /d" $ANDROID_BUILD_PATH

if [ ${BRANCH} -gt ${MIN_BRANCH} ]; then
  sed -i "/         root_build_dir)/d" $ANDROID_BUILD_PATH
fi

sed -i "/use_unstripped_as_runtime_outputs = android_unstripped_runtime_outputs/d" $ANDROID_BUILD_PATH

LIB_OUT_PATH=$SHELL_PATH/out/android
if [ ! -d "$LIB_OUT_PATH" ]; then
  mkdir -p $LIB_OUT_PATH
fi

cd $SRC_PATH && $SRC_PATH/tools_webrtc/android/build_aar.py --extra-gn-args "is_debug=true symbol_level=2 android_full_debug=true" --arch $abi --build-dir $OUT_PATH --out $OUT_PATH/libwebrtc.aar
cp $OUT_PATH/libwebrtc.aar $LIB_OUT_PATH

if [ -d "$OUT_PATH/$abi/gen" ]; then
  cp -rf $OUT_PATH/$abi/gen $LIB_OUT_PATH/
fi

LIB_OUT_PATH=$LIB_OUT_PATH/so
if [ ! -d "$LIB_OUT_PATH/$abi" ]; then
  mkdir -p $LIB_OUT_PATH/$abi
fi
cp $OUT_PATH/$abi/libjingle_peerconnection_so.so $LIB_OUT_PATH/$abi/libjingle_peerconnection_so.so
