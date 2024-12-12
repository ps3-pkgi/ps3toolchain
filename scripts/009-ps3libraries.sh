#!/bin/sh -e
# ps3libraries.sh by Naomi Peori (naomi@peori.ca)
set -x
PS3LIBRARIES="ps3libraries"

if [ ! -d ${PS3LIBRARIES} ]; then

    ## Download the source code.
    git clone https://github.com/bucanero/ps3libraries --depth=1

    ## Unpack the source code.
    rm -Rf $PS3LIBRARIES && mkdir $PS3LIBRARIES && unzip $PS3LIBRARIES.zip

fi
cd $PS3LIBRARIES

## Compile and install.
bash -x ./libraries.sh
