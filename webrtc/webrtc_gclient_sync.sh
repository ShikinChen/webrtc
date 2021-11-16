#! /bin/sh
SHELL_PATH=$(pwd)


MIRROR=$1

if [ ! -n "$MIRROR" ]; then
    MIRROR=agoralab
fi

WEBRTC_SRC=$SHELL_PATH/webrtc_src/${MIRROR}

$SHELL_PATH/webrtc_gclient_sync_init.sh $MIRROR

export PATH=$PATH:$WEBRTC_SRC/depot_tools
cp "$SHELL_PATH/boto.txt" "$WEBRTC_SRC/.boto"
export NO_AUTH_BOTO_CONFIG=$WEBRTC_SRC/.boto

# cd $WEBRTC_SRC&&fetch --nohooks webrtc
cd $WEBRTC_SRC&&gclient sync -v -f -D --with_branch_heads