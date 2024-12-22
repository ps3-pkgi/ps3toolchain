#!/bin/bash -x

sudo apt install --no-install-recommends -y curl xz-utils git aria2c \
  make \
  gcc \
  libseccomp-dev \
  libcap-dev \
  libc6-dev \
  binutils qemu-user-static debootstrap

git clone https://github.com/moe-hacker/ruri
cd ruri
cc -Wl,--gc-sections -static src/*.c src/easteregg/*.c -o ruri -lcap -lseccomp -lpthread -O3
strip ruri
cp -v ruri /usr/local/bin/
ruri -v
cd ..
#BASE_URL="https://dl-cdn.alpinelinux.org/alpine/edge/releases/aarch64"
#ROOTFS_URL=$(curl -s -L "$BASE_URL/latest-releases.yaml" | grep "alpine-minirootfs" | grep "aarch64.tar.gz" | head -n 1 | awk '{print $2}')
#FULL_URL="$BASE_URL/$ROOTFS_URL"
#wget "$FULL_URL"
#mkdir aarch64
#tar -xvf "$ROOTFS_URL" -C aarch64
sudo debootstrap --arch=arm64 --variant=minbase bookworm aarch64
rm -rf -v scripts/009-ps3libraries.sh
sudo cp -rv depends patches scripts aarch64/
sudo cp -v toolchain.sh aarch64/build.sh
sudo chmod +x -v aarch64/build.sh
rm aarch64/etc/resolv.conf
echo nameserver 1.1.1.1 >aarch64/etc/resolv.conf
sudo ./ruri/ruri -a aarch64 -q /usr/bin/qemu-aarch64-static ./aarch64 /bin/sh /build.sh
