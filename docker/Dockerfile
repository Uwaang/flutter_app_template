ARG FLUTTER_IMAGE=ghcr.io/cirruslabs/flutter:stable@sha256:7f429b29a9568705def6308f94458633e7c21d8dcf14fe6e1762f9ced3ba83b8
FROM ${FLUTTER_IMAGE}

USER root

RUN apt-get update && apt-get install -y \
    clang \
    cmake \
    git \
    libgtk-3-dev \
    liblzma-dev \
    make \
    ninja-build \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN flutter config --enable-web --enable-linux-desktop --enable-android

WORKDIR /workspace
