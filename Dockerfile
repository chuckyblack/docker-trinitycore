FROM ubuntu:xenial

# install requirements
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends mysql-client git cmake make gcc g++ libmysqlclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-dev libboost-thread-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-iostreams-dev
RUN mkdir -p /opt/trinitycore/build

# compile sources
RUN git clone -b master git://github.com/TrinityCore/TrinityCore.git /opt/trinitycore/sources
WORKDIR /opt/trinitycore/build
RUN cmake ../sources -DTOOLS=1 -DWITH_DYNAMIC_LINKING=ON -DSCRIPTS=dynamic -DUSE_COREPCH=1 -DUSE_SCRIPTPCH=1 -DCMAKE_INSTALL_PREFIX=/opt/trinitycore -DCONF_DIR=/opt/trinitycore/etc
RUN make -j$(nproc)
RUN make -j$(nproc) install

WORKDIR /opt/trinitycore

ADD scripts /scripts
