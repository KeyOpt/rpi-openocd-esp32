FROM arm32v6/alpine

WORKDIR /tmp

RUN apk --no-cache add --virtual runtime-dependencies \
      libusb \
      libftdi1 && \
      apk --no-cache add --virtual build-dependencies \
      git \
      build-base \
      libusb-dev \
      libftdi1-dev \
      automake \
      autoconf \
      libtool && \
      git clone --depth 1 https://github.com/espressif/openocd-esp32 openocd && \
      cd openocd && \
      ./bootstrap && \
      ./configure && \
      make && \
      make install && \
      apk del --purge build-dependencies && \
      rm -rf /var/cache/apk/* && \
      rm -rf /tmp/*

COPY ftdi.cfg /usr/local/share/openocd/scripts/interface/ftdi/ft2232hl_jtag_ch1.cfg

VOLUME /dev/bus/usb:/dev/bus/usb

EXPOSE 3333 4444 6666
