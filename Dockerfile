FROM ubuntu:18.04
MAINTAINER ntop.org

RUN apt-get update && \
    apt-get -y -q install wget lsb-release gnupg && \
    apt-get -y install libjson-c-dev && \
    wget -q http://apt-stable.ntop.org/16.04/all/apt-ntop-stable.deb && \
    dpkg -i apt-ntop-stable.deb && \
    apt-get clean all

RUN apt-get update && \
    apt-get -y install ntopng 

RUN echo '#!/bin/bash\n/etc/init.d/redis-server start\nntopng "$@"' > /run.sh && \
    chmod +x /run.sh

EXPOSE 443

ENTRYPOINT ["/run.sh"]
