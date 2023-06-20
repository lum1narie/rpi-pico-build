#! /bin/bash

TARGET=".env"
BASE="base.env"
BASE_EXAMPLE="base.env.example"

if [ ! -e $BASE ]; then
    cp $BASE_EXAMPLE $BASE
    echo "generated $BASE"
fi

cp $BASE $TARGET

echo "LOCAL_USER=`whoami`" >> $TARGET
echo "generated $TARGET"
