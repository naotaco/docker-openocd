FROM ubuntu:18.04

ENV DEPS="make gcc-6 automake git libtool pkg-config ca-certificates gcc"
RUN apt-get update && \
    apt-get install --no-install-recommends -y libtool libudev-dev libusb-1.0-0-dev $DEPS && \
    git clone https://github.com/daniel-k/openocd.git openocd-armv8 && \
    cd openocd-armv8 && \
    git checkout origin/armv8 && \
    ./bootstrap && \
    CC=gcc-6 ./configure --enable-ftdi && \
    make -j$(nproc) && \
    make install && \
    apt-get purge -y --auto-remove $DEPS && \
    apt-get autoremove -y

