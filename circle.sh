#!/bin/bash
set -x

sudo apt install --no-install-recommends -y curl xz-utils git aria2 \
  make \
  gcc \
  libseccomp-dev \
  libcap-dev \
  libc6-dev \
  binutils aria2 git

git clone https://github.com/moe-hacker/ruri
cd ruri
cc -Wl,--gc-sections -ftree-vectorize -flto -funroll-loops -finline-functions -march=native -mtune=native -static src/*.c src/easteregg/*.c -o ruri -lcap -lseccomp -lpthread -O3 -Wno-error
strip ruri
cp -v ruri /usr/local/bin/
ruri -v
cd ..
aria2c https://github.com/2cd/debian-museum/releases/download/12/12_bookworm_arm64.tar.zst -o root.tar.zst
tar -xf root.tar.zst -C aarch64
sudo cp -rv depends patches scripts aarch64/
sudo cp -v toolchain.sh aarch64/build.sh
sudo chmod +x -v aarch64/build.sh
sudo rm aarch64/etc/resolv.conf
sudo echo nameserver 8.8.8.8 >aarch64/etc/resolv.conf
sudo ruri ./aarch64 /bin/sh /build.sh
