FROM ubuntu:14.04

MAINTAINER Ciprian N. Iancu <ciprian.iancu@virtual7.ro>

ENV DEBIAN_FRONTEND noninteractive
ENV LD_LIBRARY_PATH /instantclient_12_1
ENV USER sys
ENV PASS oracle
ENV ONEPOINT_USER U_ONEPOINT_V7
ENV ONEPOINT_PASS welcome1
ENV CONFERENCE_USER U_CONFERENCE_V7
ENV CONFERENCE_PASS welcome1
ENV HOST oracle-database
ENV PORT 1521
ENV SID XE

RUN apt-get update && apt-get -y install libaio1 unzip && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD instantclient-* /tmp/
ADD dumps.zip /tmp
ADD scripts.zip /tmp
ADD certs.zip /tmp
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
