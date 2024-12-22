#!/bin/sh
# toolchain.sh by Naomi Peori (naomi@peori.ca)
set -x

## Enter the ps3toolchain directory.
cd "`dirname $0`" || { echo "ERROR: Could not enter the ps3toolchain directory."; exit 1; }

## Create the build directory.
mkdir -p build && cd build || { echo "ERROR: Could not create the build directory."; exit 1; }

apt update
apt -y install autoconf automake bison flex gcc g++ libelf-dev make texinfo libncurses5-dev patch python3-dev subversion git zlib1g-dev libtool-bin python-dev-is-python3 bzip2 libgmp3-dev pkg-config libssl-dev aria2

mkdir -p $PWD/ps3dev
export PS3DEV=$PWD/ps3dev
export PSL1GHT=$PS3DEV
export PATH=$PATH:$PS3DEV/bin
export PATH=$PATH:$PS3DEV/ppu/bin
export PATH=$PATH:$PS3DEV/spu/bin
export PATH=$PATH:$PS3DEV/portlibs/ppu/bin
export PKG_CONFIG_PATH=$PS3DEV/portlibs/ppu/lib/pkgconfig

## Use gmake if available
which gmake 1>/dev/null 2>&1 && export MAKE=gmake

## Fetch the depend scripts.
DEPEND_SCRIPTS=`ls ../depends/*.sh | sort`

## Run all the depend scripts.
for SCRIPT in $DEPEND_SCRIPTS; do "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; } done

## Fetch the build scripts.
BUILD_SCRIPTS=`ls ../scripts/*.sh | sort`

## If specific steps were requested...
if [ $1 ]; then

  ## Find the requested build scripts.
  REQUESTS=""

  for STEP in $@; do
    SCRIPT=""
    for i in $BUILD_SCRIPTS; do
      if [ `basename $i | cut -d'-' -f1` -eq $STEP ]; then
        SCRIPT=$i
        break
      fi
    done

    [ -z $SCRIPT ] && { echo "ERROR: unknown step $STEP"; exit 1; }

    REQUESTS="$REQUESTS $SCRIPT"
  done

  ## Only run the requested build scripts
  BUILD_SCRIPTS="$REQUESTS"
fi

## Run the build scripts.
for SCRIPT in $BUILD_SCRIPTS; do "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; } done
