### Deploy Hexo with docker-compose and deploy to github pages
Based on node:14-alpine and pull all hexo and github pages project into the container.
You only need to change container_name in docker-compose.yml. And then change the github account in build_and_run.sh.
Do what hexo need to do in your other hexo config and theme. config It will be your Hexo webserver and also you can manually deploy to your github pages.

在docker-compose中运行hexo，并部署到github pages上，请查阅[中文文档](README.zh-CN.md)了解用法。


How to Start:

1. Do whatever config change that hexo and it's theme needs.To deploy to github page, change repository name in the 'deploy' sector of theme's _config.yml
2. Modify build_and_run.sh to use your own github account. If you want to deloy to github, this is useful
3. If you have multiple sites to use this docker-container. Modifiy docker-compose.yml. change container_name to a unique one ,such as docker-my-site;
4. if you want to build existing blog/website rather than design from scratch , just pull your repository and rename it to hexo-site.
<code>
mv hexo-site hexo-site-bk
git clone your-site
mv your-site hexo-site
</code>

First time, just run

`docker-compose up --force-recreate --build`

This will build a hexo-site into the docker container. wait till you can access http://ip:4000

to exit, use ctrl+C

Next time ,you only need to run docker-compose up -d and container will be ready!


You can push whole source code to github project's master branch

To deploy the site in github pages. just run

docker exec -it docker-github-pages sh

and then inside the container,

cd "your project name"
hexo deploy
This will deploy web to github project's gh-pages branch.

Thanks
