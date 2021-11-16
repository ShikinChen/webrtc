#Dockerfile
FROM ubuntu:bionic
LABEL maintainer="shiki"

RUN apt-get update -y

RUN apt-get install -y tzdata
RUN echo "Asia/Shanghai" > /etc/timezone
RUN rm -f /etc/localtime    
RUN dpkg-reconfigure -f noninteractive tzdata




# Deps
RUN apt-get install -y vim python-pip python3-pip wget git 
RUN apt-get install -y gnupg flex bison gperf 
RUN apt-get install -y build-essential zip curl 
RUN apt-get install -y subversion pkg-config libglib2.0-dev 
RUN apt-get install -y libgtk2.0-dev libxtst-dev libxss-dev 
RUN apt-get install -y libpci-dev libdbus-1-dev libgconf2-dev 
RUN apt-get install -y libgnome-keyring-dev libnss3-dev lsb-release 
RUN apt-get install -y sudo locales libssl-dev openssl
RUN apt-get install -y cmake lbzip2 libavcodec-dev 
RUN apt-get install -y libavdevice-dev libavfilter-dev libavformat-dev 
RUN apt-get install -y libswresample-dev libpostproc-dev

RUN pip3 install dataclasses
RUN pip install dataclasses

# install webrtc deps
RUN curl https://chromium.googlesource.com/chromium/src/+/master/build/install-build-deps-android.sh?format=TEXT | base64 -d > install-build-deps-android.sh
RUN curl https://chromium.googlesource.com/chromium/src/+/master/build/install-build-deps.sh?format=TEXT | base64 -d > install-build-deps.sh
RUN chmod +x ./install-build-deps.sh
RUN chmod +x ./install-build-deps-android.sh
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN ./install-build-deps.sh --no-chromeos-fonts
RUN ./install-build-deps-android.sh

RUN locale-gen en_US.UTF-8
RUN echo 'export LANG="en_US.UTF-8"' >> ~/.bashrc

# depot tools
WORKDIR /
# RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

# RUN echo 'export PATH=$PATH:/depot_tools' >> /root/.bashrc

WORKDIR /webrtc
