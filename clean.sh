#!/bin/bash

# ~ ~ ~ ~ ~ ~ ~ 
PLUGINS=( "JSONQuery" )
# ~ ~ ~ ~ ~ ~ ~ 

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a syml$
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative syml$
done

DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
PROJECT=$(basename $DIR)

# Removing this line from the .uproject forces a rebuild
sed -i '/EngineAssociation/d' ./$PROJECT.uproject

rm -rf Binaries
rm -rf DerivedDataCache
rm -rf Intermediate
rm -rf Saved
rm -f CMakeLists.txt
rm -f Makefile

for PLUGIN in ${PLUGINS[@]}
do
    rm -rf "Plugins/"$PLUGIN"/Binaries"
    rm -rf "Plugins/"$PLUGIN"/DerivedDataCache"
    rm -rf "Plugins/"$PLUGIN"/Intermediate"
    rm -rf "Plugins/"$PLUGIN"/Saved"
done
