FROM openjdk:11

WORKDIR /app

COPY ./*.jar /app

SHELL ["/bin/bash", "-c"]

# タイムゾーンを東京に変更
ENV TZ Asia/Tokyo
ENV LANG=ja_JP.UTF-8

ENV HOST 0.0.0.0
