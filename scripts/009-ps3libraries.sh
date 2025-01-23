#!/bin/sh -x
# ps3libraries.sh by Naomi Peori (naomi@peori.ca)
set -x
PS3LIBRARIES="ps3libraries"

if [ ! -d ${PS3LIBRARIES} ]; then

    ## Download the source code.
    git clone https://github.com/ps3-pkgi/ps3libraries 

fi
cd $PS3LIBRARIES

## Compile and install.
bash ./libraries.sh
