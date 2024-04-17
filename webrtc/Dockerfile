#Dockerfile
FROM ubuntu:jammy
LABEL maintainer="shiki"

RUN apt-get update -y

RUN apt-get install -y tzdata
RUN echo "Asia/Shanghai" > /etc/timezone
RUN rm -f /etc/localtime    
RUN dpkg-reconfigure -f noninteractive tzdata


# Deps
RUN apt-get install -y vim wget git 
RUN apt-get install -y gnupg flex bison gperf 
RUN apt-get install -y build-essential zip curl 
RUN apt-get install -y subversion pkg-config libglib2.0-dev 
RUN apt-get install -y libgtk2.0-dev libxtst-dev libxss-dev 
RUN apt-get install -y libpci-dev libdbus-1-dev libgconf2-dev 
RUN apt-get install -y libnss3-dev lsb-release 
RUN apt-get install -y sudo locales libssl-dev openssl
RUN apt-get install -y cmake lbzip2 libavcodec-dev 
RUN apt-get install -y libavdevice-dev libavfilter-dev libavformat-dev 
RUN apt-get install -y libswresample-dev libpostproc-dev zlib1g-dev libbz2-dev
RUN apt-get install -y libreadline-dev libsqlite3-dev llvm libncursesw5-dev
RUN apt-get install -y xz-utils tk-dev libxml2-dev libxmlsec1-dev
RUN apt-get install -y libffi-dev liblzma-dev

SHELL ["/bin/bash", "-c"]

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN cd ~/.pyenv && src/configure && make -C src
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
RUN source ~/.bashrc
RUN ~/.pyenv/bin/pyenv install 3.9.17
RUN ~/.pyenv/bin/pyenv global 3.9.17

RUN ~/.pyenv/versions/3.9.17/bin/pip install install --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org  dataclasses
RUN ~/.pyenv/versions/3.9.17/bin/pip install vpython
RUN ln -s ~/.pyenv/versions/3.9.17/bin/python /usr/bin/python

# install webrtc deps
RUN curl https://chromium.googlesource.com/chromium/src/+/refs/heads/main/build/install-build-deps.py?format=TEXT | base64 -d > install-build-deps.py
RUN chmod +x ./install-build-deps.py
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN ./install-build-deps.py --no-chromeos-fonts --android

RUN locale-gen en_US.UTF-8
RUN echo 'export LANG="en_US.UTF-8"' >> ~/.bashrc

# depot tools
WORKDIR /
# RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

# RUN echo 'export PATH=$PATH:/depot_tools' >> /root/.bashrc

WORKDIR /webrtc
