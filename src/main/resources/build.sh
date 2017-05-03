#!/bin/bash

set -Eex

baseDir=$1
targetDir=$2
classesOutputDir=$3
shift 3

install -d "$targetDir/generated-sources/c"

# JNI
javah -classpath "$classesOutputDir" \
    -d "$targetDir/generated-sources/c" \
    JNIAccess

if [ "$(uname)" == "Darwin" ]; then
  gcc -dynamiclib -shared -fPIC -O2 -g \
      -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/darwin" \
      -I"$targetDir/generated-sources/c" \
      -o "$targetDir/libjniaccess.jnilib" \
      "$baseDir/src/main/c/jniaccess.c"
else
  gcc -shared -fPIC -O2 -g \
      -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/linux" \
      -I"$targetDir/generated-sources/c" \
      -o "$targetDir/libjniaccess.so" \
      "$baseDir/src/main/c/jniaccess.c"
fi

