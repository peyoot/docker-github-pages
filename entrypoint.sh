#!/bin/sh
pnpm install 
# 设置git
git config --global user.name "${GITHUB_USER}" 
git config --global user.email "${GITHUB_EMAIL}"
if [ ! -d /hexo/source ] ; then 
    if [ -z "${GITHUB_REPO}" ] ; then 
        git clone git@github.com:${GITHUB_USER}/${GITHUB_REPO} temp; 
    else 
        hexo init temp ; 
    fi; 
ls -A temp|grep -v _config.yml |xargs -i cp -rf temp/{} ./ ;
rm -rf temp ;
fi
echo "hexo site is ready"

