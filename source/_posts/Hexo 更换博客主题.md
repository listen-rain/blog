---
title: Hexo 更换博客主题
date: 2018-05-11 02:19:48
tags: 
- hexo
category:
- hexo
---

由于原主题 black-blue 的搜索效果不好，页面显示感觉混乱，现更换为 hexo-theme-yilia 主题

<!-- more -->

## 下载和安装

注：首次安装 hexo 请参考：[Hexo 搭建](http://listenwei.com/2018/05/04/Hexo-%E5%8D%9A%E5%AE%A2%E6%90%AD%E5%BB%BA/)

[github 地址](https://github.com/litten/hexo-theme-yilia)，下载：
``` bash
git clone https://github.com/litten/hexo-theme-yilia.git themes/yilia
```

重启博客服务: 
```
docker restart myhexo  # 本次使用的 docker 搭建
```

## 配置

```bash
# cat themes/yilia/_config.yml

--------------------------------
# Header
menu:
  主页: /
  归档: /archives/
  友链: /friends/
  关于: /about/

# 标题
title: 祝凤伟

# 副标题
subtitle: 执着的蜗牛

# SubNav
subnav:
  github: "https://github.com/listenwei"
  weibo: "#"
  rss: "/atom.xml"
  mail: "mailto:m15275049388@163.com"

rss: /atom.xml

# Content
# 文章太长，截断按钮文字
excerpt_link: more
# 注意：此配置的使用方法是在'文章的内容中加入 <!-- more --> ，用来截取掉此位置以下的内容'
# 文章卡片右下角常驻链接，不需要请设置为false
show_all_link: '全文'
# 数学公式
mathjax: false
# 是否在新窗口打开链接
open_in_new: false

#你的头像url
avatar: https://xxxxx.jpg

# 站点小图标地址
favicon: /img/favicon.jpg

#是否开启分享
baidushare: true

#是否开启云标签
tagcloud: true

#3、畅言
changyan_appid: xxx
changyan_conf: xxxxx

smart_menu:
  #innerArchive: '所有文章'
  friends: '友链'
  aboutme: '关于我'
  
smart_menu:
  innerArchive: '搜索'
  friends: '友链'
  aboutme: '关于我'

friends:
  友情链接1: http://localhost:4000/
  友情链接2: http://localhost:4000/
  ......

aboutme: xxxxxx
```

### 安装搜索支持

```bash
# 搜索插件
cnpm install hexo-generator-search --save

# json 支持插件
cnpm i hexo-generator-json-content --save

# 在 blog/_config.yml，配置：
search:
  path: search.json
  field: all
  
jsonContent:
    meta: false
    pages: false
    posts:
      title: true
      date: true
      path: true
      text: false
      raw: false
      content: false
      slug: false
      updated: false
      comments: false
      link: false
      permalink: false
      excerpt: false
      categories: false
      tags: true
```

## 注册并配置畅言

- [畅言官网地址](http://changyan.kuaizhan.com/)

- 修改 themes/yilia/_config.yml 中的 changyan_appid 和 changyan_conf 即可

## 样式修改

> [源码修改、编译参考](https://github.com/litten/hexo-theme-yilia/wiki/Yilia%E6%BA%90%E7%A0%81%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84%E5%8F%8A%E6%9E%84%E5%BB%BA%E9%A1%BB%E7%9F%A5)

本次为省事，直接修改编译文件，主样式配置文件是 themes/yilia/source/main.0cf68a.css

- 为使归档中的文章列表中的标签处于标题正下方，而不是右下方，在 main.0cf68a.css 中搜索：.article-info.info-on-right，将 float:left 改为 float:inherit

- 为使文章中的字体看着更匀称，搜索： font-size: 14px 全部改为 font-size: 16px ，搜索 .article-entry pre 添加 font-size: 15px

- 为使标签显示在标题下方，而不是页脚，修改 /themes/yilia/layout/_partial/article.ejs, 修改成如下：

```html
# header 中添加标签显示
<header class="article-header">
        <%- partial('post/title', {class_name: 'article-title'}) %>
        <% if (!post.noDate){ %>
        <%- partial('post/date', {class_name: 'archive-article-date', date_format: null}) %>
        <% } %>
        <div class="tag-div">
            <%- partial('post/tag') %>
            <%- partial('post/category') %>
        </div>
</header>

# 删除页脚的标签显示
<div class="article-info article-info-index">
            <%- partial('post/tag') %> # 删除
            <%- partial('post/category') %> # 删除
</div>
```
修改样式，main.0cf68a.css 中添加：.tag-div{margin:10px 0 40px 0;}

## 在文章摘要中加入预览图

- 参考：https://www.fanhaobai.com/2017/03/install-hexo.html

修改文件: blog/node_modules/hexo/lib/plugins/filter/after_post_render/excerpt.js，修改内容如下：
```js
content.replace(rExcerpt, function(match, index) {
   data.excerpt = content.substring(0, index).trim();
   data.more = content.substring(index + match.length).trim();
   data.content = data.excerpt.replace(/<img(.*)>/, '') + data.more;
   return '<a id="more"></a>';
});
```
说明：文章摘要预览图不会在文章正文中显示。

# 默认配置文件

- blog/node_modules/hexo/lib/hexo/default_config.js
