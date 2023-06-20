FROM debian:11.6-slim


RUN apt-get -y update && apt-get -y install apt-utils
RUN apt-get -y install \
    cmake \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    build-essential \
    python3 \
    git \
    gosu

ARG LOCAL_UID=9000 \
    LOCAL_GID=9000 \
    LOCAL_USER=user \
    LOCAL_GROUP=user

ENV LOCAL_USER=$LOCAL_USER

RUN useradd -u $LOCAL_UID -o -m $LOCAL_USER && \
    groupmod -g $LOCAL_GID $LOCAL_GROUP

WORKDIR /home/$LOCAL_USER
USER $LOCAL_USER:$LOCAL_GROUP

RUN mkdir pico && \
    git clone https://github.com/raspberrypi/pico-sdk.git \
    --depth 1 --single-branch --branch master pico/pico-sdk && \
    git clone https://github.com/raspberrypi/pico-examples.git \
    --depth 1 --single-branch --branch master pico/pico-examples && \
    git clone https://github.com/raspberrypi/pico-extras.git \
    --depth 1 --single-branch --branch master pico/pico-extras && \
    git clone https://github.com/raspberrypi/pico-playground.git \
    --depth 1 --single-branch --branch master pico/pico-playground

WORKDIR /home/$LOCAL_USER/pico/pico-sdk
RUN git submodule update --init \
    --recommend-shallow --depth 1

ENV PICO_SDK_PATH=/home/$LOCAL_USER/pico/pico-sdk \
    PICO_EXAMPLES_PATH=/home/$LOCAL_USER/pico/pico-examples \
    PICO_EXTRAS_PATH=/home/$LOCAL_USER/pico/pico-extras \
    PICO_PLAYGROUND_PATH=/home/$LOCAL_USER/pico/pico-playground

WORKDIR /

USER root
RUN mkdir /target && chown $LOCAL_USER:$LOCAL_GROUP /target
COPY build_pico.sh /home/$LOCAL_USER/build_pico.sh
RUN chmod +x /home/$LOCAL_USER/build_pico.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
