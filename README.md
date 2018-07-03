[![Build Status](https://travis-ci.org/CS-Tao/GTD-Docker.svg?branch=master)](https://travis-ci.org/CS-Tao/GTD-Docker)
[![Build status](https://ci.appveyor.com/api/projects/status/a2xnp089t7c4piy3/branch/master?svg=true)](https://ci.appveyor.com/project/CS-Tao/gtd-docker/branch/master)
[![license](https://img.shields.io/badge/license-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![chat](https://img.shields.io/badge/chat-github%20issues-blue.svg)](https://github.com/CS-Tao/GTD-Docker/issues)

# 全球恐怖袭击数据可视化系统 - Docker 部署方案

> Global Terrorist Attacks Visualization System - Deploy Solution by Docker-compose

## 项目结构

### 服务堆栈

- postgis

- django

- nginx

### 内部网络

- network

### 容器间通信

- postgis

- django

- nginx

### 数据卷

- postgresql-data

- uwsgi-sock

- static-files

- logs

## 环境变量

- ENV_DOCKER_USER

- ENV_NGINX_PORT

- ENV_POSTGIS_PORT

- ENV_POSTGRES_DB

- ENV_POSTGRES_USER

- ENV_POSTGRES_PASSWD

- ENV_POSTGRES_PASSWD_ADMIN

## 编排命令 - 针对开发者

- 构建镜像

  本地构建：
  ```bash
  ```
  或者从 [cloud.docker.com](https://cloud.docker.com/swarm/cstao/repository/list) 拉取
  ```bash
  ```

- 创建并启动服务 - 同步

  同步：
  ```bash
  ```
  异步：
  ```bash
  ```

- 启动/停止/重启服务

  启动：
  ```bash
  ```
  停止：
  ```bash
  ```
  重启：
  ```bash
  ```

- 暂停/恢复服务

  暂停：
  ```bash
  ```
  恢复：
  ```bash
  ```

- 停止并移除由 `docker-compose.yml` 定义的服务容器和网络

  ```bash
  ```
