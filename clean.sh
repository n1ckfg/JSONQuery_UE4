#!/bin/bash

# ~ ~ ~ ~ ~ ~ ~ 
#PLUGINS=( "jsonquery" )
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
    rm -rf "Plugins/"$PLUGIN"_unreal_plugin/Binaries"
    rm -rf "Plugins/"$PLUGIN"_unreal_plugin/DerivedDataCache"
    rm -rf "Plugins/"$PLUGIN"_unreal_plugin/Intermediate"
    rm -rf "Plugins/"$PLUGIN"_unreal_plugin/Saved"
done
