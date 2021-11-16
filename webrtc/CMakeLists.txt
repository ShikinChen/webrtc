cmake_minimum_required(VERSION 3.8)

project(webrtc_project)

set(ANDROID_ABI arm64-v8a)
set(WEBRTC_REPO ${CMAKE_SOURCE_DIR}/webrtc_src/google/src)
set(WEBRTC_BUILD_DIR ${CMAKE_SOURCE_DIR}/webrtc_src/google/src/out/android_debug/${ANDROID_ABI})

add_subdirectory(${CMAKE_SOURCE_DIR}/../android/webrtc webrtc)