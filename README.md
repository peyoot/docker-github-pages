### Deploy Hexo with docker-compose and deploy to github pages
Based on node:14-alpine and pull all hexo and github pages project into the container.
You only need to change container_name in docker-compose.yml. And then specify your github account and repo name in .env file.

Do what hexo need to do in your other hexo config and theme. config It will be your Hexo webserver and also you can manually deploy to your github pages.

在docker-compose中运行hexo，并部署到github pages上，请查阅[中文文档](README.zh-CN.md)了解用法。


How to Start:

1. Do whatever config change that hexo and it's theme needs.To deploy to github page, please specify the github account and repo name in .env file.
2. Make sure your host PC ssh key have been added to github as password based commit won't be support any more.
3. If you have multiple sites to use this docker-container. Modifiy docker-compose.yml. change container_name to a unique one ,such as docker-my-site;


First time, just rename env.sample to .env and use your own github account.

then run

`docker-compose up --force-recreate --build`

This will pull a hexo-site into the docker container . wait till you can access http://ip:4000

to exit, use ctrl+C

Next time ,you only need to run docker-compose up -d and container will be ready!

If you don't specify the GITHUB_REPO, it simply create a new hexo site.

You can push whole source code to github project's master branch

To deploy the site in github pages. just run

docker exec -it docker-github-pages sh

and then inside the container,

hexo clean
hexo deploy
This will deploy web to github project's gh-pages branch.

Thanks
