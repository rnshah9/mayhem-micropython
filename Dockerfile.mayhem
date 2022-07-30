FROM --platform=linux/amd64 ubuntu:20.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential pkg-config libffi-dev

ADD . /repo
WORKDIR /repo/ports/unix
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3
RUN make -j8 submodules
RUN make -j8

RUN mkdir -p /deps
RUN ldd /repo/ports/unix/micropython | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I % sh -c 'cp % /deps;'

FROM ubuntu:20.04 as package

COPY --from=builder /deps /deps
COPY --from=builder /repo/ports/unix/micropython /repo/ports/unix/micropython
ENV LD_LIBRARY_PATH=/deps
