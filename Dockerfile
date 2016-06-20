FROM ubuntu:xenial
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y git cmake make gcc g++ libmysqlclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-dev libboost-thread-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-iostreams-dev mysql-server p7zip
RUN mkdir -p /opt/TrinityCore/build
RUN git clone -b 6.x git://github.com/TrinityCore/TrinityCore.git /opt/TrinityCore/sources
RUN cd /opt/TrinityCore/build && cmake ../sources -DTOOLS=1  -DCMAKE_INSTALL_PREFIX=/opt/TrinityCore -DCONF_DIR=/opt/TrinityCore/etc
RUN cd /opt/TrinityCore/build && make -j$(nproc)
RUN cd /opt/TrinityCore/build && make -j$(nproc) install
RUN cd /opt/TrinityCore/build && make -j$(nproc) clean
