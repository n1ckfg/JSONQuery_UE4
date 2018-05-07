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

$UE_ROOT"/GenerateProjectFiles.sh" -game $DIR"/"$PROJECT".uproject"

make $PROJECT
