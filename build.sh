#!/bin/bash

# ~ ~ ~ ~ ~ ~ ~ 
UE_ROOT=$HOME"/UnrealEngine"
# ~ ~ ~ ~ ~ ~ ~

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a syml$
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative syml$
done

DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
PROJECT=$(basename $DIR)

# Clean
# removing this line from the .uproject forces a rebuild
sed -i '/EngineAssociation/d' ./$PROJECT.uproject

rm -rf Binaries
rm -rf DerivedDataCache
rm -rf Intermediate
rm -rf Saved
rm -f CMakeLists.txt
rm -f Makefile

for d in ./Plugins/*; do
  if [ -d "$d" ]; then
    rm -rf $d"/Binaries"
    rm -rf $d"/DerivedDataCache"
    rm -rf $d"/Intermediate"
    rm -rf $d"/Saved"
  fi
done

#Build
$UE_ROOT"/GenerateProjectFiles.sh" -game $DIR"/"$PROJECT".uproject"

make $PROJECT
