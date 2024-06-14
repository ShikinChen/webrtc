#! /bin/sh
DIRECTORY=$(dirname "$0")
DIRECTORY=$(cd "$DIRECTORY" && pwd -P)

docker build -t webrtc_build "$DIRECTORY" --progress=plain #--no-cache
$SHELL