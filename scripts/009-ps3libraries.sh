#!/bin/sh -e
# ps3libraries.sh by Naomi Peori (naomi@peori.ca)
set -x
PS3LIBRARIES="ps3libraries"

if [ ! -d ${PS3LIBRARIES} ]; then

    ## Download the source code.
     aria2c https://github.com/humbertodias/$PS3LIBRARIES/tarball/psl1ght-2.30.1 -o $PS3LIBRARIES.tar.gz

    ## Unpack the source code.
    rm -Rf $PS3LIBRARIES && mkdir $PS3LIBRARIES && tar --strip-components=1 --directory=$PS3LIBRARIES -xzf $PS3LIBRARIES.tar.gz

fi

cd $PS3LIBRARIES

## Compile and install.
bash -x ./libraries.sh
