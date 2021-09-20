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

# 维护者信息
MAINTAINER peyoot <peyoot@hotmail.com>

# 工作目录
WORKDIR /hexo

RUN echo "Asia/Shanghai" > /etc/timezone \
    && apk add --no-cache git \
# 安装Hexo
    && npm install hexo-cli -g \
    && hexo init . \
#RUN npm install
#    && echo "https://mirrors.ustc.edu.cn/alpine/v3.9/main/" > /etc/apk/repositories  \
#    && npm config set registry https://registry.npm.taobao.org \
    && npm install hexo-deployer-git \
    && npm install hexo-generator-search \
    && npm install hexo-render-pug \
    && npm install hexo-renderer-stylus \
    && npm install hexo-wordcount \
# 设置git
    && git config --global user.name "$GITHUB_USER" \
    && git config --global user.email "$GITHUB_EMAIL" 

# 映射端口
EXPOSE 4000

# 运行命令
#CMD ["/bin/bash"]
CMD ["/usr/bin/env", "hexo", "server"]
#CMD ["/bin/sh"]
