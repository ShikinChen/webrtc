#! /bin/sh
DIRECTORY=$(dirname "$0")
DIRECTORY=$(cd "$DIRECTORY" && pwd -P)

exec docker build -t webrtc_build --progress=plain "$@" "$DIRECTORY"
