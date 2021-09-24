### 运行hexo，并部署到github pages上的docker-compose项目
基于node:14-alpine镜像，支持本地hexo和docker来运维和部署。只需在.env中指定GITHUB_REPO就可以自动拉取相关的库进行部署。
hexo及其主题的可配置和正常hexo类似。这个容器将是你hexo的web服务器，并且你可以部署到github pages上。

#### 用法
1. 拉取项目
```
git clone https://github.com/peyoot/docker-github-pages.git
```
2. 根据需要修改hexo及其主题的配置，要部署到github pages上，请在环境配置文件.env中配置这三个变量：
GITHUB_USER
GITHUB_EMAIL
GITHUB_REPO
其中如果指定GITHUB_REPO会拉取该REPO到本地hexo-site目录中。
运行docker-compose up -d来生成hexo server服务。
要进行部署，请在github上添加您电脑上的ssh key，然后按步骤6的方式进入容器内部执行hexo clean && hexo deploy

3. 如果您有多个站点要使用这个容器工具，请复制一份，并在docker-compose.yml中把容器名改为独一无二的名称（默认是docker-github-pages）

4. 如果不用docker，而是想在电脑host上运行hexo，一样的效果，进入hexo-site执行即可。（确保node14已经安装，hexo-cli也全局安装了）
<code>
pnpm install
hexo server
</code>

第一次使用，运行

```
docker-compose up
或是修改后重新编译
docker-compose up --force-recreate --build
```
这会编译该站点的容器，请静等一会儿，直到可以打开http://ip:4000，显示正常博客页面。 按ctrl+c退出。
下次只需运行：

```
 docker-compose up -d
```
站点容器就能准备好。

6. 部署到github pages:
运行
```
docker exec -it docker-github-pages sh
```
在容器中直接运行hexo deploy来推送网站内容到gh-pages分支上，以完成部署。
