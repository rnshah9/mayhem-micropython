FROM --platform=linux/amd64 ubuntu:20.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential pkg-config libffi-dev git python3
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y clang lld
RUN ln -s /usr/bin/ld.lld /usr/bin/ld -f

COPY . /repo
WORKDIR /repo/ports/unix
RUN cp /repo/mayhem/fuzz_qstr_compute_hash.c /repo/ports/unix/main.c
RUN sed -i 's/CFLAGS += $(INC) $(CWARN) -std=gnu99 -DUNIX $(CFLAGS_MOD) $(COPT) -I$(VARIANT_DIR) $(CFLAGS_EXTRA)/CFLAGS += $(INC) $(CWARN) -std=gnu99 -DUNIX $(CFLAGS_MOD) $(COPT) -I$(VARIANT_DIR) $(CFLAGS_EXTRA) -fsanitize=address,fuzzer/' /repo/ports/unix/Makefile
RUN sed -i 's/LDFLAGS += $(LDFLAGS_MOD) $(LDFLAGS_ARCH) -lm $(LDFLAGS_EXTRA)/LDFLAGS += $(LDFLAGS_MOD) $(LDFLAGS_ARCH) -lm $(LDFLAGS_EXTRA) -fsanitize=address,fuzzer/' /repo/ports/unix/Makefile
RUN make -j8 CC=clang CXX=clang++

FROM ubuntu:20.04 as package
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libffi-dev
COPY --from=builder /repo/ports/unix/micropython /fuzz_qstr_compute_hash
