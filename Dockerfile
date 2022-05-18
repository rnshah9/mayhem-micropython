FROM --platform=linux/amd64 ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential pkg-config libffi-dev

ADD . /repo
WORKDIR /repo/ports/unix
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3
RUN make -j8 submodules
RUN make -j8
