FROM python:3.9-alpine as builder

ENV TZ Asia/Shanghai

WORKDIR /app

COPY requirements.txt /app

RUN apk update -f && \
    apk upgrade && \
    apk --no-cache --virtual build add sed build-base libffi-dev openssl-dev tzdata &&\
    apk --no-cache add \
    jpeg-dev \
    zlib-dev \
    libmagic \
    libwebp-dev \
    ffmpeg \
    cairo \
    git \
    freetype-dev \
    openjpeg-dev \
    gifsicle \
    cairo-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    pip uninstall werkzeug && \
    pip install werkzeug==2.3.0 && \
    rm -rf /var/cache/apk/* && \
    rm -rf ~/.cache && \
    apk del build && \
    rm -rf /usr/local/src/* 

ENTRYPOINT ["ehforwarderbot"]
