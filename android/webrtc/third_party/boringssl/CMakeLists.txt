cmake_minimum_required(VERSION 3.8)

set(ANDROID true)
execute_process(
        COMMAND whereis go
        OUTPUT_VARIABLE GO_EXECUTABLE
        OUTPUT_STRIP_TRAILING_WHITESPACE
)
add_subdirectory(${WEBRTC_REPO}/third_party/boringssl/src boringssl)
