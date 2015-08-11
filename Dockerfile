FROM debian:jessie
MAINTAINER Nicholas Iaquinto <nickiaq@gmail.com>

ENV LUA_HASH 913fdb32207046b273fdb17aad70be13
ENV LUA_MAJOR_VERSION 5.2
ENV LUA_MINOR_VERSION 4
ENV LUA_VERSION ${LUA_MAJOR_VERSION}.${LUA_MINOR_VERSION}

RUN apt-get update && \
    apt-get install -y build-essential curl libreadline-dev && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /usr/src/lua && \
    cd /usr/src/lua && \
    curl -R -O http://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz && \
    echo "${LUA_HASH} lua-${LUA_VERSION}.tar.gz" | md5sum -c - && \
    tar zxf lua-${LUA_VERSION}.tar.gz && \
    cd lua-${LUA_VERSION} && \
    make linux test && \
    make install && \
    cd .. && \
    rm -rf *.tar.gz lua-${LUA_VERSION} && \
    apt-get purge -y --auto-remove build-essential curl libreadline-dev

CMD ["/usr/local/bin/lua"]
