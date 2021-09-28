FROM golang:alpine as builder

RUN apk add --no-cache --virtual .build-deps build-base gcc git && apk add --no-cache leveldb-dev

RUN git clone https://bitbucket.org/decimalteam/go-node /usr/local/src/go-node

RUN cd /usr/local/src/go-node && make all && cd / && rm -rf /usr/local/src/go-node

FROM golang:alpine

RUN adduser -D -u 1000 decimal && mkdir -p /home/decimal/.decimal

COPY --from=builder /go/bin/* /usr/local/bin/

RUN apk add leveldb-dev curl

RUN chown -R decimal:decimal /home/decimal

COPY startup.sh /usr/local/bin/startup.sh 

USER decimal

WORKDIR /home/decimal

HEALTHCHECK --interval=10s --timeout=5s --retries=3 --start-period=30s CMD curl -f http://localhost:26657/status || exit 1

ENTRYPOINT [ "/usr/local/bin/startup.sh" ]
