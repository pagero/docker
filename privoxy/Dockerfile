FROM alpine:3.8

RUN apk --update add \
  ca-certificates curl privoxy jq && \
  mv /etc/privoxy/templates /etc/privoxy-templates && \
  rm -rf /var/cache/apk/* /etc/privoxy/*

EXPOSE 8118/tcp

VOLUME [ "/etc/privoxy" ]

ENTRYPOINT ["privoxy", "--no-daemon", "/etc/privoxy/config"]
