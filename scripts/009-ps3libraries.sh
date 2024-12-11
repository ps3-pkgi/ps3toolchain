#!/bin/sh -e
# ps3libraries.sh by Naomi Peori (naomi@peori.ca)
set -x
PS3LIBRARIES="ps3libraries"

if [ ! -d ${PS3LIBRARIES} ]; then

    ## Download the source code.
     aria2c https://github.com/bucanero/ps3libraries/archive/refs/heads/master.zip -o $PS3LIBRARIES.zip

    ## Unpack the source code.
    rm -Rf $PS3LIBRARIES && mkdir $PS3LIBRARIES && unzip $PS3LIBRARIES.zip

fi
mv ps3libraries-master ps3libraries
cd $PS3LIBRARIES

## Compile and install.
bash -x ./libraries.sh
