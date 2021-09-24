#!/bin/sh
pnpm install 
# 设置git
echo "check github_user is ${GITHUB_USER}"
echo "check github_email is ${GITHUB_EMAIL}"
echo "check github_repo is ${GITHUB_REPO}"
git config --global user.name "${GITHUB_USER}" 
git config --global user.email "${GITHUB_EMAIL}"
if [ ! -d /hexo/source/_posts ] ; then
  echo "empty hexo-site without any source posts" 
  if [ -n "${GITHUB_REPO}" ] ; then 
      echo "you have specified the github repo" ;
      git clone git@github.com:${GITHUB_USER}/${GITHUB_REPO} temp ; 
  else 
      echo "no github repo provided, will generate a new hexo site" ;
      hexo init temp ; 
  fi ; 
#  ls -A temp|xargs -i cp -rf temp/{} ./ ;
  ls -A temp|grep -v _config.yml |xargs -i cp -af temp/{} ./ ;
  echo "" > _config.yml ;
  cat temp/_config.yml >>_config.yml ;
#  rm -rf temp ;
else
  echo "hexo-site with source posts mounted" ;
fi ;
echo "hexo site is ready!" 
#hexo server
#hexo clean
#hexo g
#hexo d
#hexo server
top
