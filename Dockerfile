FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y build-essential automake libtool libudev-dev pkg-config libusb-1.0-0-dev gcc-6 git

RUN apt-get install -y iputils-ping curl

RUN git clone https://github.com/daniel-k/openocd.git openocd-armv8 && \
    cd openocd-armv8 && \
    git checkout origin/armv8 && \
    git submodule update --init --recursive --recommend-shallow --depth 1 && \
    ./bootstrap && \
    CC=gcc-6 ./configure --enable-ftdi && \
    make -j$(nproc) && \
    make install
    
RUN openocd
    
