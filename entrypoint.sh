#!/bin/bash

cd /home/$LOCAL_USER
exec /usr/sbin/gosu $LOCAL_USER /bin/bash -c '$HOME/build_pico.sh'
