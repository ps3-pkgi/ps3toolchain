#!/bin/sh -e
# ps3libraries.sh by Naomi Peori (naomi@peori.ca)
set -x
PS3LIBRARIES="ps3libraries"

if [ ! -d ${PS3LIBRARIES} ]; then

    ## Download the source code.
    git clone https://github.com/bucanero/ps3libraries --depth=1

fi
cd $PS3LIBRARIES

## Compile and install.
bash -x ./libraries.sh
