FROM ghcr.io/cirruslabs/flutter:stable

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
