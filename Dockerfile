FROM debian:12.5-slim


RUN apt-get -y update && apt-get -y install apt-utils
RUN apt-get -y install \
    cmake \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    build-essential \
    python3 \
    git \
    ninja-build \
    doxygen \
    graphviz

ARG UID GID USER GROUP
ENV LOCAL_USER=$USER

RUN groupadd -g ${GID} ${GROUP} && \
    useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USER}

WORKDIR /home/$USER
USER $UID:$GID

RUN mkdir pico && \
    git clone https://github.com/raspberrypi/pico-sdk.git \
    --depth 1 --single-branch --branch master pico/pico-sdk && \
    git clone https://github.com/raspberrypi/pico-examples.git \
    --depth 1 --single-branch --branch master pico/pico-examples && \
    git clone https://github.com/raspberrypi/pico-extras.git \
    --depth 1 --single-branch --branch master pico/pico-extras && \
    git clone https://github.com/raspberrypi/pico-playground.git \
    --depth 1 --single-branch --branch master pico/pico-playground

WORKDIR /home/$USER/pico/pico-sdk
RUN git submodule update --init \
    --recommend-shallow --depth 1

ENV PICO_SDK_PATH=/home/$USER/pico/pico-sdk \
    PICO_EXAMPLES_PATH=/home/$USER/pico/pico-examples \
    PICO_EXTRAS_PATH=/home/$USER/pico/pico-extras \
    PICO_PLAYGROUND_PATH=/home/$USER/pico/pico-playground

WORKDIR /

USER root
RUN mkdir /target && chown $UID:$GID /target
COPY build_pico.sh /usr/local/bin/build_pico.sh
RUN chmod +x /usr/local/bin/build_pico.sh

WORKDIR /home/$USER
ENV CMAKE_COLOR_DIAGNOSTICS=always
USER $UID:$GID

ENTRYPOINT [ "/usr/local/bin/build_pico.sh" ]
