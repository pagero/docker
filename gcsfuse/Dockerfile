FROM golang:1.11-alpine3.9 AS build

RUN apk --update add git
RUN go get github.com/googlecloudplatform/gcsfuse

FROM alpine:3.9
RUN apk add --no-cache ca-certificates fuse && rm -rf /tmp/*
COPY --from=build /go/bin/gcsfuse /usr/local/bin
RUN ["sh", "-c", "echo user_allow_other >> /etc/fuse.conf"]

COPY docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
