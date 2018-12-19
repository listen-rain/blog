#!/bin/bash

rsync -e "ssh -p 61020" -tvzr --exclude-from=.deployignore $PWD/public/*  root@test.listenrain.top:/www/hexo/blog
