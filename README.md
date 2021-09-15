# oh-my-wechaty-dev

你的第一个 wechaty Docker 开发环境。
## 使用方法
  1. 安装最新版 Docker 客户端，并运行 Docker 启用docker-compose（window默认安装，其它平台自行了解配置。）
  2. 国内用户建议按照[这篇教程](https://www.runoob.com/docker/docker-mirror-acceleration.html)配置加速镜像
  3. 在本地创建目录 my-projects
  4. 使用 VSCode 打开 my-projects，安装 [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) 插件
  5. 创建 my-project/docker-compose.yml，并在文件中写入 

    ```

    version: "3.7"
    services:
      my-project:
        container_name: my-project
        image: humorwang/oh-my-wechaty-dev:latest
        volumes:
          - .:/workspace
        ports:
          # 这里是映射端口 前面是系统的端口，后面是容器内项目端口，可以不一致。
          # 如下外部通过 localhost:3001 访问项目的监听在3000上的服务
          - 3001:3000

    ```
  6. 在 VSCode 中运行命令（按下快捷键 ctrl+shift+p）输入 Reopen in Container 回车选 from "docker-compose.yml" 启动
稍等片刻，你就可以开发wechaty 项目了，镜像默认已经安装好了chromium，代码里会跳过安装的。


## 常见问题

### 如何连接外部主机的mysql等服务？

可以用这个项目 [docker-host](https://github.com/qoomon/docker-host) 详细使用可以自行去项目学习，这里提供一个例子：

```
version: "3.7"
services:
  docker-host:
    container_name: mybot-host
    image: qoomon/docker-host
    cap_add: [ 'NET_ADMIN', 'NET_RAW' ]
    restart: on-failure
    environment:
      - PORTS=3306
  # 项目中用到数据库的地方本地开始是127.0.0.1的配置改成 docker-host 就可以了
  mybot:
    container_name: mybot
    image: humorwang/oh-my-wechaty-dev:latest
    volumes:
        - .:/workspace
    ports:
      - 3001:3001
    depends_on:
      - docker-host

```
用的时候最好手动拉一下这个镜像  docker pull qoomon/docker-host
