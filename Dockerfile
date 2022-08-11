FROM --platform=linux/amd64 ubuntu:22.04 AS build
LABEL author="hundehausen" \
      maintainer="hundehausen"
      
ENV MONERO_VERSION=0.18.1.0 MONERO_SHA256=9318e522a5cf95bc856772f15d7507fdef2c028e01f70d020078ad5e208f1304

RUN apt-get update && apt-get install -y curl bzip2

WORKDIR /root

RUN curl https://dlsrc.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256  monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-x86_64-linux-gnu-v$MONERO_VERSION/monerod . &&\
  rm -r monero-*

FROM --platform=linux/amd64 ubuntu:22.04

RUN apt-get update && apt-get install --no-install-recommends -y wget
RUN useradd -ms /bin/bash monero && mkdir -p /home/monero/.bitmonero && chown -R monero:monero /home/monero/.bitmonero
USER monero
WORKDIR /home/monero

COPY --chown=monero:monero --from=build /root/monerod /home/monero/monerod

# blockchain location
VOLUME /home/monero/.bitmonero

EXPOSE 18080 18081
HEALTHCHECK --interval=30s --timeout=5s CMD wget --no-verbose --tries=1 --spider http://localhost:18081/get_info || exit 

ENTRYPOINT ["./monerod"]
CMD ["--non-interactive", "--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind", "--enable-dns-blocklist", "--no-zmq", "--out-peers=16", "--prune-blockchain"]
