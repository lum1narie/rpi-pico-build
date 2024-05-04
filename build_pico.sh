#! /bin/bash

for TARGET in $(find /target -mindepth 1 -maxdepth 1 -type d); do
    cd $TARGET
    cmake -H. -Bbuild -DCMAKE_EXPORT_COMPILE_COMMANDS=YES -GNinja
    cmake --build build -j$(echo "$(nproc) + 1" | bc)
done
