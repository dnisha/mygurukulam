#!/bin/bash

docker run \
    --privileged  \
    --rm \
    -it \
    --cpuset-cpus="1" \
    -v $(pwd)/centosdata:/src \
    centos:7 \
    /bin/bash