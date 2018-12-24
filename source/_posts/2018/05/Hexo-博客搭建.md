---
title: Hexo 博客搭建
date: 2018-05-04 02:22:15
tags:
- hexo
- node
category: 
- hexo
---

Hexo 是一个快速、简洁且高效的博客框架。Hexo 使用 Markdown 解析文章，方便用户快速的完成一篇文章

<!-- more -->

# 安装

### 安装 node 

- [win 下载地址](http://nodejs.cn/download/)

### Centos 安装

```bash
$ yum install nodejs

$ node -v
$ npm -v
```

### 为了节省时间，安装 node 后还是使用国内镜像吧
    
```bash
$ npm install -g cnpm --registry=https://registry.npm.taobao.org
$ cnpm --help  # cnpm 和 npm 命令一致，只是 cnpm 使用的是国内镜像，相对于 npm 速度极快
```

### 安装 Hexo 并创建一个博客服务

- [Hexo 官方文档](https://hexo.io/zh-cn/docs/index.html)
    
```bash
$ npm install hexo-cli -g  
$ hexo init blog
$ cd blog
$ npm install
$ hexo server
```
- 安装成功会提示：Hexo is running at http://localhost:4000/.
- Hexo 主配置文件是 blog 根目录的 _config.yml，主要修改其中的：title、author、url，analytics 暂可不用

### 命令参考 

- 官方文档： [Hexo Commands](https://hexo.io/docs/commands.html)
- 如果是 docker 容器部署(本次是)，最好做命令映射 
- 以下是常用示例

```bash
hexo s                     # 静态启动服务 
hexo new [layout] <title>  # 新建文章
hexo g                     # 生成静态文件 
```

# 切换主题
- 本次使用 black-blue 主题

### 安装

```bash
# 下载
cd themes && git clone https://github.com/maochunguang/black-blue

# 修改
_config.yml theme: black-blue
```

### 安装常用插件
```bash
cd blog

## 站点sitemap生成插件
cnpm install hexo-generator-sitemap --save
cnpm install hexo-generator-baidu-sitemap --save

## 百度url提交
cnpm install hexo-baidu-url-submit --save

## 本地搜索插件集成
cnpm install hexo-generator-search --save

## rss插件
cnpm install hexo-generator-feed --save

## git 部署插件
cnpm install hexo-deployer-git --save
```

# 修改全局配置，修改根目录下_config.yml

### 插件配置
```
Plugins:
- hexo-generator-feed
- hexo-generator-sitemap
- hexo-generator-baidu-sitemap
```

### rss设置
```bash
feed:
  type: atom
  path: atom.xml
  limit: 20
```

### 本地搜索配置
```bash
search:
  path: search.json
  field: post
```

### 站点地图，seo搜索引擎需要
```bash
sitemap:
  path: sitemap.xml
baidusitemap:
  path: baidusitemap.xml
```

### 菜单配置
```
menu:
  主页: /
  所有文章: /archives/
  友情链接: /friends/
  标签: /tags/
  关于个人: /about/
```

### 评论配置
```bash
# 是否开启畅言评论
changyan:
  on: false
  appid: xxxx
  conf: xxxx
  
# 是否开启disqus，
disqus:
  on: false
  shortname: xxxx
```
### git 部署配置
```bash
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: <repository>
  branch: <branch>
  message:
```

### 其他配置，详细的配置在配置文件中都有注释
```bash
# 数学公式支持
mathjax: false

# Socail Share | 是否开启分享
baidushare: true

# 谷歌分析，百度分析，seo分析很有用
google_analytics: xxxx
baidu_analytics: xxxx
```

### 生成目录
```bash
hexo new page about
hexo new page tags
hexo new page friends
```

### 修改头像和标题图标
```bash
# Link to your avatar | 填写头像地址
avatar: /img/avatar.jpg

# Small icon of Your site | 站点小图标地址
favicon: /img/favicon.jpg
```

# 新建文章

### 修改文章模板 scaffolds/post.md
```bash
title: {{ title }}
date: {{ date }}
description:        # 为使主页的文章列表，只显示标题和描述，必须添加 description
tags:
```

### 新建一篇文章
```bash
$ hexo new [layout] <title> 
```

### 效果如图

![hexo-blog](http://alioss.markdown.listenwei.com/blog/hexo.png)

### git 部署上线

```bash
# 别忘了创建 ignore 文件，忽略不必要的文件夹

git init 
git remote add origin <repository>
git config --global ...
git add --all .
hexo d
```

### 参考

- https://hexo.io/zh-cn/docs/index.html
- https://geeksblog.cc/
- https://www.fanhaobai.com
