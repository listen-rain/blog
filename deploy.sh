#!/bin/bash

rsync -tvzr --exclude-from=.deployignore $PWD/public/*  root@test.listenrain.top:/www/hexo/public
