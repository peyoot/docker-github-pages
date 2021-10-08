#!/bin/sh
pnpm install 
# 设置git
echo "check github_user is ${GITHUB_USER}"
echo "check github_email is ${GITHUB_EMAIL}"
echo "check github_repo is ${GITHUB_REPO}"
git config --global user.name "${GITHUB_USER}" 
git config --global user.email "${GITHUB_EMAIL}"
if [ ! -d /hexo/source/_posts ] ; then
  echo "empty hexo-site without any source posts" ;
#  hexo init temp ;
  git clone https://github.com/hexojs/hexo-starter.git temp ;
  if [ -n "${GITHUB_REPO}" ] ; then 
      echo "you have specified the github repo" ;
      git clone git@github.com:${GITHUB_USER}/${GITHUB_REPO} temprepo ; 
      cp -af temprepo/. temp ;
  else 
      echo "no github repo provided,a new hexo site generated" ;
  fi ; 

  if [ -n "{HEXO_THEME_NAME}" ] ; then
    echo "your have specified the theme" ;
    if [ "`ls -A /hexo/themes`" = "" ] ; then
        echo "no theme available, will download the specified one" ;
        git clone ${HEXO_THEME_REPO} temp/themes/${HEXO_THEME_NAME} ;
#        sed -i "s/^theme: landscape/theme: ${HEXO_THEME_NAME}/" temp/_config.yml ;
        sed -i "/^theme:/ c\theme: ${HEXO_THEME_NAME}" temp/_config.yml ;
        sed -i '/^deploy:/,$d' temp/_config.yml ;
        echo "deploy:" >> temp/_config.yml ;
        echo "  type: git" >> temp/_config.yml ;
        echo "  repo: git@github.com:${GITHUB_USER}/${GITHUB_REPO}" >> temp/_config.yml ;
        echo "  branch: gh-pages" >> temp/_config.yml ; 
    else
        echo "you've got a theme in the folder, nothing changed" ;
    fi;
  else
    echo "no theme specified, please manually download and config it." ;

  fi;

#  ls -A temp|xargs -i cp -rf temp/{} ./ ;
  ls -A temp|grep -v _config.yml |grep -v package.json |xargs -i cp -af temp/{} ./ ;
  echo "" > _config.yml ;
  cat temp/_config.yml >>_config.yml ;
  rm -rf temp* ;
else
  echo "hexo-site with source posts mounted" ;
fi ;

#chmod -R a+w source
#chmod -R a+w themes
#chmod -R a+w scaffolds
echo "hexo site is ready!" 
#hexo server
#hexo clean
#hexo g
#hexo d
hexo server
#top
#
