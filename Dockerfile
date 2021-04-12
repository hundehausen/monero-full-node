FROM ubuntu:20.04 AS build
LABEL author="hundehausen" \
      maintainer="hundehausen"
      
ENV MONERO_VERSION=0.17.2.0 MONERO_SHA256=59e16c53b2aff8d9ab7a8ba3279ee826ac1f2480fbb98e79a149e6be23dd9086

RUN apt-get update && apt-get install --no-install-recommends -y curl bzip2

WORKDIR /root

RUN curl https://dlsrc.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256  monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-x86_64-linux-gnu-v$MONERO_VERSION/monerod . &&\
  rm -r monero-*

FROM ubuntu:20.04

RUN useradd -ms /bin/bash monero && mkdir -p /home/monero/.bitmonero && chown -R monero:monero /home/monero/.bitmonero
USER monero
WORKDIR /home/monero

COPY --chown=monero:monero --from=build /root/monerod /home/monero/monerod

# blockchain location
VOLUME /home/monero/.bitmonero

EXPOSE 18080 18081
HEALTHCHECK --interval=30s --timeout=5s CMD /bin/bash curl --fail http://localhost:18081/get_info || exit 1

ENTRYPOINT ["./monerod"]
CMD ["--non-interactive", "--rpc-restricted-bind-ip=0.0.0.0", "--rpc-restricted-bind-port=18081", "--no-zmq", "--out-peers=16"]
