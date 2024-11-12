#!/usr/bin/bash

JAVA_VER="21.0.1"
export JAVA_VER="21.0.1"
export JAVA_HOME="/home/cdsw/java-21/jdk-${JAVA_VER}"

JAVA_TGZ=openjdk-${JAVA_VER}_linux-x64_bin.tar.gz
JAVA_DL_URL="https://download.java.net/java/GA/jdk${JAVA_VER}/415e3f918a1f4062a0074a2794853d0d/12/GPL/${JAVA_TGZ}"

mkdir java-21 2>/dev/null
cd java-21

## Install Java ##
wget --no-verbose -O ${JAVA_TGZ} ${JAVA_DL_URL}
tar xzf ${JAVA_TGZ} && rm ${JAVA_TGZ}
