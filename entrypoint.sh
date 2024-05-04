#!/bin/bash

cd /home/$LOCAL_USER
exec env CMAKE_COLOR_DIAGNOSTICS=always /usr/sbin/gosu $LOCAL_USER /bin/bash -c '$HOME/build_pico.sh '"$@"
