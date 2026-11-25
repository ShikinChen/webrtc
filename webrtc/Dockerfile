#Dockerfile
FROM ubuntu:jammy
LABEL maintainer="shiki"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -o APT::Update::Error-Mode=any \
    && apt-get install -y \
        tzdata ca-certificates \
        vim wget git \
        gnupg flex bison gperf \
        build-essential zip curl \
        subversion pkg-config libglib2.0-dev \
        libgtk2.0-dev libxtst-dev libxss-dev \
        libpci-dev libdbus-1-dev libgconf2-dev \
        libnss3-dev lsb-release \
        sudo locales libssl-dev openssl \
        cmake lbzip2 libavcodec-dev \
        libavdevice-dev libavfilter-dev libavformat-dev \
        libswresample-dev libpostproc-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev llvm libncursesw5-dev \
        xz-utils tk-dev libxml2-dev libxmlsec1-dev \
        libffi-dev liblzma-dev \
    && rm -rf /var/lib/apt/lists/*
RUN echo "Asia/Shanghai" > /etc/timezone
RUN rm -f /etc/localtime    
RUN dpkg-reconfigure -f noninteractive tzdata


RUN echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
SHELL ["/bin/bash", "-c"]

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN cd ~/.pyenv && src/configure && make -C src
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
RUN source ~/.bashrc
RUN ~/.pyenv/bin/pyenv install 3.9.17
RUN ~/.pyenv/bin/pyenv global 3.9.17

RUN ~/.pyenv/versions/3.9.17/bin/pip install --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org  dataclasses
RUN ~/.pyenv/versions/3.9.17/bin/pip install vpython
RUN ln -s ~/.pyenv/versions/3.9.17/bin/python /usr/bin/python


# install webrtc deps
RUN curl https://chromium.googlesource.com/chromium/src/+/refs/heads/main/build/install-build-deps.py?format=TEXT | base64 -d > install-build-deps.py
RUN chmod +x ./install-build-deps.py
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN ./install-build-deps.py --no-prompt --no-chromeos-fonts --android

RUN locale-gen en_US.UTF-8
RUN echo 'export LANG="en_US.UTF-8"' >> ~/.bashrc

# depot tools
WORKDIR /
# RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

# RUN echo 'export PATH=$PATH:/depot_tools' >> /root/.bashrc

WORKDIR /webrtc
