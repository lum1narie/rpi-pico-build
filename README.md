# Raspberry Pi Pico builder Docker image

## Overview

Docker image to build codes for Raspberry Pi Pico using C/C++ Pico-SDK

## How to use

### Requirement

+ Bash
+ Docker

### Install

Build docker image
```shell
make build
```

If you use in multi-user environment, please build image for each user to use.
(see [Specification/Permission](#permission))

When you need to set image name, see
[How to use/Usage/Setting Docker image name](#setting-docker-image-name)

### Usage

The build product will be generated in the `build` directory
directly under your project for Raspberry Pi Pico.
Please ensure that you do not use this directory.

#### Build Raspberry Pi Pico project

Before use, you need to build docker image (see [Install](#install))

You can build Raspberry Pi Pico project by this command.
(Default image name is `rpi-pico-build`)
```shell
docker run --rm -t -v <project directory>:/target/<project name> <image>
```

When you are in the target directory, this command will work.
```shell
docker run --rm -t -v $(PWD):/target/$(basename $(PWD)) <image>
```

#### Multi targets

If you mount multi projects in `/target/` of the container,
all of them are built simultaneously.

#### Target name in CMake

You can give CMake target as the argument of `docker run`.
```shell
docker run --rm -t -v $(PWD):/target/$(basename $(PWD)) <image> <target>
```

#### Setting Docker image name

You can set image name by modifying `$IMAGE` in `base.env` before building image.

If `base.env` is not exist on building container,
`base.env` is automatically generated as a copy of `base.env.example`.

### Uninstall

Remove image then remove all dangling images.
```shell
make clean
```

## Specification

### CMake option

CMake option is set in `build_pico.sh` currently.

+ output directory is `build/`
+ generate `compile_commands.json`
+ use ninja to build
+ run processor number + 1 jobs

### Permission

This container will capture and register your user name and ID
when its image is built,
in order to correctly specify the permissions of the build product.

Therefore, if a different user uses this image,
the image must be re-built and a new image must be used.
