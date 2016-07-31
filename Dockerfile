FROM ubuntu:xenial

# install requirements
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends wget git cmake make gcc g++ libmysqlclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-dev libboost-thread-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-iostreams-dev mysql-server p7zip
RUN mkdir -p /opt/trinitycore/build

# compile sources
RUN git clone -b 6.x git://github.com/TrinityCore/TrinityCore.git /opt/trinitycore/sources
WORKDIR /opt/trinitycore/build
RUN cmake ../sources -DTOOLS=1 -DWITH_DYNAMIC_LINKING=ON -DSCRIPTS=dynamic -DCMAKE_INSTALL_PREFIX=/opt/trinitycore -DCONF_DIR=/opt/trinitycore/etc
RUN make -j$(nproc)
RUN make -j$(nproc) install

# database
ADD scripts/database.sh /scripts/
RUN /scripts/database.sh

# configuration
WORKDIR /opt/trinitycore
RUN mkdir log
RUN sed 's/DataDir = "."/DataDir = "..\/data"/g; s/LogsDir = ""/LogsDir = "..\/log"/g' etc/worldserver.conf.dist > etc/worldserver.conf
RUN sed 's/LogsDir = ""/LogsDir = "..\/log"/g' etc/bnetserver.conf.dist > etc/bnetserver.conf

# start
ADD scripts/init.sh scripts/infiniteLoop.sh /scripts/

ENTRYPOINT ["/scripts/init.sh"]
