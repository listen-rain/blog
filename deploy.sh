#!/bin/bash

rsync -e "ssh -p 61020" -atvzr --delete --exclude-from=.deployignore $PWD/public/ root@test.listenrain.top:/www/hexo/public/

