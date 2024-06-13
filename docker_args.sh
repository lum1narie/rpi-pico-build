#! /bin/bash

echo -n "--build-arg UID=$(id -u) "
echo -n "--build-arg GID=$(id -g) "
echo -n "--build-arg USER=$(whoami) "
echo -n "--build-arg GROUP=$(id -ng) "
