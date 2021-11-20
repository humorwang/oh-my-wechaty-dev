FROM node:16.13.0-alpine

LABEL maintainer="humorwang <wangyan4170@gmail.com>"

WORKDIR /tmp
ENV SHELL /bin/bash

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# basic tools
RUN apk update && apk upgrade \
    && apk add --no-cache \
    udev  \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    coreutils \
    curl \
    ffmpeg \
    figlet \
    jq \
    moreutils \
    cmake bash git vim \
    xauth  
#end


ENV EDITOR=/usr/bin/vim
ENV VISUAL=/usr/bin/vim


# Dev env for JS
RUN apk add --no-cache yarn&& \
    npm config set registry=https://registry.npm.taobao.org; 
# end


# Python 3 and pip
ENV PYTHONUNBUFFERED=1
ADD pip.cn.conf /root/.config/pip/pip.conf
RUN apk add --update --no-cache python3 &&\
    ln -sf python3 /usr/bin/python &&\
    python3 -m ensurepip &&\
    pip3 install --no-cache --upgrade pip setuptools
# end


# zsh
ENV SHELL /bin/zsh
ADD .bash_aliases /root/.bash_aliases
RUN apk add --no-cache zsh &&\
    zsh -c 'git clone https://code.aliyun.com/412244196/prezto.git /root/.zprezto' &&\
    zsh -c 'setopt EXTENDED_GLOB' &&\
    zsh -c 'for rcfile in /root/.zprezto/runcoms/z*; do ln -s "$rcfile" "/root/.${rcfile:t}"; done' &&\
    echo 'source /root/.bash_aliases' >> /root/.zshrc
# end

RUN npm config set registry https://registry.npm.taobao.org \
    && npm config set disturl https://npm.taobao.org/dist \
    && npm config set puppeteer_download_host https://npm.taobao.org/mirrors 

#  set PUPPETEER
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
# end 

RUN yarn add puppeteer@10.2.0


RUN export WECHATY_PUPPET=wechaty-puppet-wechat



