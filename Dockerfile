# *****************************************************************************
# File Name: Dockerfile
# Auther: peyoot
# Email: peyoot @ hotmail.com
# Description:
#
#    dockerfile for hexo
#
# *****************************************************************************
# 基础镜像
FROM node:14-alpine

ARG GITHUB_USER
ARG GITHUB_EMAIL
#ENV GITHUB_TOKEN=${GITHUB_TOKEN}

# 维护者信息
MAINTAINER peyoot <peyoot@hotmail.com>
LABEL author=peyoot site=https://peyoot.github.io/docker-github-pages

COPY entrypoint.sh entrypoint.sh


# 工作目录
WORKDIR /hexo

#RUN echo "Asia/Shanghai" > /etc/timezone \
RUN apk add --update --no-cache git openssh \
# 安装pnpm
    && npm install -g pnpm \
    && pnpm add -g pnpm \
# 安装Hexo
    && pnpm add hexo-cli -g \
#    && hexo init temp \
#    && if [ ! -d /hexo/source ] ; then hexo init temp ; ls -A temp|grep -v _config.yml |xargs -i cp -rp temp/{} ./ ; rm -rf temp ; fi \
#    && hexo init . \
    && pnpm add hexo-deployer-git \
    && pnpm add hexo-generator-search \
    && pnpm add hexo-render-pug \
    && pnpm add hexo-renderer-stylus \
    && pnpm add hexo-wordcount 
RUN pnpm install \
# 设置git
    && git config --global user.name "${GITHUB_USER}" \
    && git config --global user.email "${GITHUB_EMAIL}" \ 
    && if [ ! -d /hexo/source ] ; then \
         if [ -z "${GITHUB_REPO}" ] ; then \
           git clone git@github.com:${GITHUB_USER}/${GITHUB_REPO} temp; \
         else hexo init temp ; \
         fi; \
       ls -A temp|grep -v _config.yml |xargs -i cp -rf temp/{} ./ ; \
       rm -rf temp ; \
       fi \
    && echo "hexo site is ready"


# 挂载volume
VOLUME ["/hexo/.deploy_git", "/hexo/scaffolds", "/hexo/source", "/hexo/themes","/root/.ssh"]

# 映射端口
EXPOSE 4000

# 运行命令
#CMD ["/usr/bin/env", "hexo", "server"]
#CMD ["/bin/sh"]
ENTRYPOINT ["/usr/bin/env","sh","/entrypoint.sh"]
