#! /bin/bash

echo -n "--build-arg LOCAL_UID=$(id -u) "
echo -n "--build-arg LOCAL_GID=$(id -g) "
echo -n "--build-arg LOCAL_USER=$(whoami) "
echo -n "--build-arg LOCAL_GROUP=$(id -ng) "
