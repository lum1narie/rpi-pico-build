#! /bin/bash

if [ $# -gt 0 ]; then
    CMAKE_TARGET="-t $1"
else
    CMAKE_TARGET=
fi

for PROJECT in $(find /target -mindepth 1 -maxdepth 1 -type d); do
    cd $PROJECT
    cmake -H. -Bbuild -DCMAKE_EXPORT_COMPILE_COMMANDS=YES -GNinja
    cmake --build build ${CMAKE_TARGET} -j$(($(nproc)+1))
done
