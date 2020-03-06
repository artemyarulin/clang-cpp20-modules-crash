FROM ubuntu:19.10

WORKDIR /clang
RUN apt-get update && apt-get install -y wget gnupg2 make && \
    wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/eoan/ llvm-toolchain-eoan main" > /etc/apt/sources.list.d/llvm.list && \
    apt-get update && \
    apt-get install -y clang lld

WORKDIR /src
COPY Makefile *.cc *.h ./
RUN clang++ --version && make app
