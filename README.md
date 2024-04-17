### WebRTC Android的c++源码在mac调试项目 调试方式来源于[macOS 下单步调试 WebRTC Android & iOS](https://blog.piasy.com/2018/08/14/build-webrtc/index.html) 和 [简单有效的 Android 调试方法](https://webrtc.mthli.com/basic/webrtc-breakpoint/), 而编译方式和服务器搭建来源于[WebRTC Native 开发实战(许建林)](https://item.jd.com/12939784.html)

<br>

### 源码下载、编译和服务器搭建都是基于[docker](https://www.docker.com/)

<br>

### 拉取和编译源码

在项目目录下的webrtc目录下用终端执行下面相关操作  
第一次先构建镜像

```
cd webrtc
./build_image.sh
```

<mark>
如果想使用Google源下载而且开了科学上网的代理,要配置boto.txt文件和webrtc_build.sh脚本,默认代理端口使用了privoxy默认端口的8118,不一样请对boto.txt文件和webrtc_build.sh脚本进行修改</mark>
boto.txt文件

```
[Boto]
proxy = 127.0.0.1
proxy_port = 8118 #代理端口
```

```shell
MIRROR=$1
IS_PROXY=$2

PROXY_PORT=8118 #代理端口

```

构建成功后,启动容器，拉取WebRTC源码  
```shell
./webrtc_build.sh
./gclient_sync.sh init
```


如果结合[WebRTC Native 开发实战(许建林)](https://item.jd.com/12939784.html) 进行学习最好切换30432的提交并且进行同步
最好在容器执行切换
```
cd src
git checkout be99ee8f17f93e06c81e3deb4897dfa8253d3211 -b commit_30432
//或者切换m84
git checkout -f branch-heads/4147 -b m84
//或者切换m124
git checkout -f branch-heads/6367 -b m124
cd ..
./gclient_sync.sh
```

### 编译

### Android编译

创建临时容器并且在进入容器bash环境执进入编译,如果已经创建过用回当前就行,默认是google源路径和开启代理,<mark>webrtc_build.sh脚本默认科学上网的代理端口是8118,不一样进行修改</mark>

```
./webrtc_build.sh 
```

如果用声网源和不用代理proxy-off 就是下面命令

```
./webrtc_build.sh agoralab proxy-off
```

执行下面脚本命令进行打包,脚本已经unstrip可以直接执行,打包后就可以调试,打包完后有可能会提示ERROR:root:Missing
licenses的协议生成错误这个可以不用处理只要生成libjingle_peerconnection_so.so就行,最后libjingle_peerconnection_so.so在<mark>
webrtc-build/webrtc_android/src/out/arm64-v8a</mark>

```
cd /webrtc
./build_android.sh
```

<br> 

### Android Studio调试

整个项目的cmake配置使用[macOS 下单步调试 WebRTC Android & iOS提供的github项目](https://github.com/HackWebRTC/webrtc) 方便源码跳转 ,调试方式很简单直接用Android
Studio打开android目录,最好同步一下2-3次项目让gradle正确同步好WebRTC的c++源码目录便于调试,然后直接可以在主要的c++源码打断点进行调试


### 启动服务器

直接执行项目下的webrtc_server.sh脚本,而且调试项目默认是本机所在局域网的ip,如果服务器不是在本机运行,修改android/AppRTCMobile的build.gradle脚本的pref_room_server_url_default参数值,再使用Android
Studio启动调试,因为默认值直接会保存到手机本地,如果局域网的ip,改变需要先卸载在安装或者自行在demo设置正确ip

```
./webrtc_server.sh
```
