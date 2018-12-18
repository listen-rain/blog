---
title: compose 安装与卸载 
date: 2018-05-03 08:46:29
tags: 
- docker
- compose 
category:
- docker
---

compose 是 docker 官方推荐的 docker 容器集群管理工具，能极其方便的管理容器集群

<!-- more -->

## 安装方式
    
- Compose 支持 Linux、macOS、Windows 10 三大平台。
- Compose 可以通过 Python 的包管理工具 pip 进行安装，也可以直接下载编译好的二进制文件使用，甚至能够直接在 Docker 容器中运行。
- Docker for Mac 、Docker for Windows 自带 docker-compose 二进制文件，安装 Docker 之后可以直接使用。
- compose 安装十分简单，本次只探讨在容器中执行的方式。

## 容器中执行

- 从 官方 [GitHub Release](https://github.com/docker/compose/releases) 处直接下载编译好的二进制文件即可，需要注意系统位数

``` bash
$ sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

## 查看 run.sh 文件

``` bash
set -e

VERSION="1.8.0"
IMAGE="docker/compose:$VERSION"


# Setup options for connecting to docker host
if [ -z "$DOCKER_HOST" ]; then
    DOCKER_HOST="/var/run/docker.sock"
fi
if [ -S "$DOCKER_HOST" ]; then
    DOCKER_ADDR="-v $DOCKER_HOST:$DOCKER_HOST -e DOCKER_HOST"
else
    DOCKER_ADDR="-e DOCKER_HOST -e DOCKER_TLS_VERIFY -e DOCKER_CERT_PATH"
fi


# Setup volume mounts for compose config and context
if [ "$(pwd)" != '/' ]; then
    VOLUMES="-v $(pwd):$(pwd)"
fi
if [ -n "$COMPOSE_FILE" ]; then
    compose_dir=$(dirname $COMPOSE_FILE)
fi
# TODO: also check --file argument
if [ -n "$compose_dir" ]; then
    VOLUMES="$VOLUMES -v $compose_dir:$compose_dir"
fi
if [ -n "$HOME" ]; then
    VOLUMES="$VOLUMES -v $HOME:$HOME -v $HOME:/root" # mount $HOME in /root to share docker.config
fi

# Only allocate tty if we detect one
if [ -t 1 ]; then
    DOCKER_RUN_OPTIONS="-t"
fi
if [ -t 0 ]; then
    DOCKER_RUN_OPTIONS="$DOCKER_RUN_OPTIONS -i"
fi

exec docker run --rm $DOCKER_RUN_OPTIONS $DOCKER_ADDR $COMPOSE_OPTIONS $VOLUMES -w "$(pwd)" $IMAGE "$@"
```

- 它会拉取 compose 镜像，当使用时会启用一个临时容器，使用结束又自动删除了容器

 
## 卸载

- 容器中的执行的方式其实是独立于系统的，不想使用时，直接删除 compose 镜像即可

## compose 常用命令

``` bash
docker-compose up -d   # 后台启动
docker-compose down    # 销毁
docker-compose restart # 重启
```