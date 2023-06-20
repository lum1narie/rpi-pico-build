#! /bin/bash

for TARGET in $(find /target -mindepth 1 -maxdepth 1 -type d); do
    cd $TARGET
    # mkdir -p build
    # cd build
    # cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=YES ..
    cmake -H. -Bbuild -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
    cd build
    make -j$(nproc)
done
