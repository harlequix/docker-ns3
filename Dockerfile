FROM ubuntu:22.04

ARG Version=3.40

RUN apt-get update
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get install -y \
    wget \
    bzip2 \
    python3 \
    cmake \
    g++

RUN mkdir -p /usr/ns3
WORKDIR /usr/ns3
RUN wget https://www.nsnam.org/release/ns-allinone-${Version}.tar.bz2
RUN tar xjf ns-allinone-${Version}.tar.bz2 && rm ns-allinone-${Version}.tar.bz2
RUN cd ns-allinone-${Version} && ./build.py --enable-examples --enable-tests
RUN ln -s /usr/ns3/ns-allinone-${Version}/ns-${Version} /usr/ns3/ns3-latest
WORKDIR /usr/ns3/ns3-latest

