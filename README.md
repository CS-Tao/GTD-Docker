[![Build Status](https://travis-ci.org/CS-Tao/GTD-Docker.svg?branch=master)](https://travis-ci.org/CS-Tao/GTD-Docker)
[![Build status](https://ci.appveyor.com/api/projects/status/a2xnp089t7c4piy3/branch/master?svg=true)](https://ci.appveyor.com/project/CS-Tao/gtd-docker/branch/master)
[![license](https://img.shields.io/badge/license-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![chat](https://img.shields.io/badge/chat-github%20issues-blue.svg)](https://github.com/CS-Tao/GTD-Docker/issues)

# 全球恐怖袭击数据可视化系统 - Docker 部署方案

> Global Terrorist Attacks Visualization System - Deploy Solution by Docker-compose

[![Overview](https://github.com/CS-Tao/github-content/raw/master/contents/github/GTD/1.webp)](https://projects.cs-tao.cc/gtd-visualization/web)

## 项目结构

- 项目地址：[https://github.com/CS-Tao/GTD-Docker](https://github.com/CS-Tao/GTD-Docker)

- 镜像仓库:
  - [cstao/gtd-postgis](https://store.docker.com/community/images/cstao/gtd-postgis)
  - [cstao/gtd-django](https://store.docker.com/community/images/cstao/gtd-django)
  - [cstao/gtd-nginx](https://store.docker.com/community/images/cstao/gtd-nginx)

### 服务堆栈

- postgis

  数据库容器，负责数据服务，数据导入在此模块中完成

- django

  后台服务容器，负责数据 API 的提供

- nginx

  反向代理服务器，负责静态文件的代理和 Django API 的反向代理

### 容器间通信

三个容器均处于 `network` 网络下，通信 IP 为容器的服务名

- postgis

  在 `network` 网络内部暴露 `5432` 端口，供 `django` 容器连接

- django

  连接 `postgis` 容器的 `5432` 端口，并使用 `uwsgi` 开启 socket 通信，对生成的 `gtd-background.sock` 文件实现持久化，供 `nginx` 访问

- nginx

  通过 `gtd-background.sock` 文件和 `django` 容器通信

### 数据卷

- postgresql-data

  储存 `postgis` 容器的数据

- uwsgi-sock

  储存 `gtd-background.sock` 文件，提供 `django` 容器和 `nginx` 容器的通信

- static-files

  负责静态文件的持久化。静态文件由 `django` 容器和 `nginx` 容器产生，由 `nginx` 容器负责代理

- logs

  存放日志文件。`postgresql` 文件夹存放 `postgis` 容器的数据库日志，`django-uwsgi` 文件夹存放 `django` 容器的访问日志，`nginx` 文件夹存放 `nginx` 容器的代理日志

## 环境变量

所有的环境变量在 `.env` 文件中定义，一共 7 个

- ENV_DOCKER_USER

  镜像用户，默认为 `cstao`

- ENV_NGINX_PORT

  `nginx` 容器对外暴露的数据 API 和静态文件的访问端口，默认为 `2001`

- ENV_POSTGIS_PORT

  `postgis` 容器对外暴露的数据库连接端口，默认为 `2032`

- ENV_POSTGRES_DB

  存放数据的数据库，默认为 `gtdb`

- ENV_POSTGRES_USER

  访问 `ENV_POSTGRES_DB` 的用户，默认为 `cstao`

- ENV_POSTGRES_PASSWD

  `ENV_POSTGRES_USER` 用户的密码，默认为 `cstao`

- ENV_POSTGRES_PASSWD_ADMIN

  `postgres` 用户的密码，默认为 `0000`

## 编排命令

- 构建镜像

  本地构建：
  ```bash
  docker-compose build
  ```
  或者从 [store.docker.com](https://store.docker.com/profiles/cstao) 拉取：
  ```bash
  docker-compose pull
  ```

- 创建并启动服务

  同步：
  ```bash
  docker-compose up
  ```
  异步：
  ```bash
  docker-compose up -d
  ```

- 导入数据到 postgresql 数据库

  利用 `docker ps` 命令得到 `postgis` 容器的 `ID`，然后在 `postgis` 容器中执行导入数据的命令(`pg_dumped_data-url` 应该替换为自定义的 sql 数据的 URL，如果不指定该参数，则默认使用 `https://github.com/CS-Tao/GTD-Docker/releases/download/v1.0.0/gtdb.sql` 作为源数据)：
  ```bash
  docker exec -i <postgis-container-id> import_data [pg_dumped_data-url]
  ```

- 启动/停止/重启服务

  启动：
  ```bash
  docker-compose start
  ```
  停止：
  ```bash
  docker-compose stop
  ```
  重启：
  ```bash
  docker-compose restart
  ```

- 暂停/恢复服务

  暂停：
  ```bash
  docker-compose pause
  ```
  恢复：
  ```bash
  docker-compose unpause
  ```

- 停止并移除由 `docker-compose.yml` 定义的服务容器和网络
  
  - 添加 `--rmi type` 参数可以移除镜像，`tpye` 可以为 `all` 或 `local`，`all` 表示移除所有镜像，`local` 表示只移除没有定义标签的镜像
  - 添加 `-v` 或 `--volume` 参数可以移除所有在 `docker-compose.yml` 中定义的数据卷

  ```bash
  docker-compose down [--rmi <all>|<local>] [-v|--volume]
  ```

## Maintainer

  | [<img src="https://avatars2.githubusercontent.com/u/22360632?s=400&u=1e8c0b49ed6ee28a1911f69d29176fd918c54897&v=4" width="100px;"/><br /><sub><b>CS-Tao</b></sub>](https://github.com/CS-Tao) | 
  | :---: |