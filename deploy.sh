#!/bin/bash

# 设置远程仓库的地址
remote_url="git@github.com:iHTCboy/NotesEveryDay.git"
# 获取当前时间
cur_date="`date +%Y-%m-%d-%H:%M:%S`" 

# 生成_book文件
gitbook build

rm -rf .deploy_git #/* | egrep .deploy_git/.git
if [ ! -d ".deploy_git/" ];then
	cp -R _book/ .deploy_git/
else
	cp -R _book/* .deploy_git/
fi
cd .deploy_git/
git init
git remote add origin $remote_url
# 删除本地和远端的gh-pages分支
#git branch -D gh-pages
#git branch -D -r origin/gh-pages
#git push origin :gh-pages
git checkout -b gh-pages
git add -A
git commit -m $cur_date
git push -f origin gh-pages