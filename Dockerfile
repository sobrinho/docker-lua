FROM debian:jessie
MAINTAINER Nicholas Iaquinto <nickiaq@gmail.com>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential curl zip unzip libreadline-dev && \
    apt-get clean && \
    mkdir /usr/bin/lua

WORKDIR /usr/bin/lua
ENV LUA_HASH 913fdb32207046b273fdb17aad70be13
ENV LUA_MAJOR_VERSION 5.2
ENV LUA_MINOR_VERSION 4
ENV LUA_VERSION ${LUA_MAJOR_VERSION}.${LUA_MINOR_VERSION}
RUN echo "${LUA_HASH} lua-${LUA_VERSION}.tar.gz" > lua-${LUA_VERSION}.md5 && \
    curl -R -O http://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz && \
    md5sum -c lua-${LUA_VERSION}.md5 && \
    tar zxf lua-${LUA_VERSION}.tar.gz && \
    cd lua-${LUA_VERSION} && \
    make linux test && make install && \
    cd .. && rm -rf *.tar.gz *.md5 lua-${LUA_VERSION}

CMD ["/usr/local/bin/lua"]
