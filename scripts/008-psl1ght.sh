#!/bin/sh -e
# psl1ght.sh by Naomi Peori (naomi@peori.ca)
set -x
PSL1GHT_DIR="PSL1GHT"

if [ ! -d ${PSL1GHT_DIR} ]; then

    ## Download the source code.
    aria2c https://github.com/ps3dev/$PSL1GHT_DIR/tarball/master -o $PSL1GHT_DIR.tar.gz

    ## Unpack the source code.
    rm -Rf $PSL1GHT_DIR && mkdir $PSL1GHT_DIR && tar --strip-components=1 --directory=$PSL1GHT_DIR -xzf $PSL1GHT_DIR.tar.gz

fi

cd $PSL1GHT_DIR

## Compile and install.
${MAKE:-make} VERBOSE=1 V=1 install-ctrl && ${MAKE:-make} VERBOSE=1 V=1 && ${MAKE:-make} VERBOSE=1 V=1 install
