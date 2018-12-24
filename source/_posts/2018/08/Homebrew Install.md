---
title: Homebrew Install
date: 2018-08-09 10:41:24
tags: 
- mac
- brew
category:
---

Homebrew 是 Mac 下的软件包管理工具，使用 Homebrew 安装 Apple 没有预装但 你需要的东西。

<!-- more -->

## 官方的安装方法

> 注意：会踩坑

[官方文档](https://brew.sh/index_zh-cn)

命令

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## 下载 install 文件

```bash
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install >> brew_install
```

## 中科院的镜像

```bash
git clone git://mirrors.ustc.edu.cn/homebrew-core.git/ /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core --depth=1
```

## 把 homebrew-core 的镜像地址也设为中科院的国内镜像
 
```bash
cd "$(brew --repo)" && git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
 
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" && git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
```

## 安装

```bash
ruby brew_install
```

## 换源操作

#### 替换核心软件仓库

```bash
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" && git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
```

#### 替换 cask 软件仓库（提供 macOS 应用和大型二进制文件）

```bash
cd "$(brew --repo)"/Library/Taps/caskroom/homebrew-cask && git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
```

#### 替换 Bottles 源（Homebrew 预编译二进制软件包）

```bash
// bash（默认 shell）用户：

echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile

source ~/.bash_profile

// zsh 用户：

echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc

source ~/.zshrc
```
