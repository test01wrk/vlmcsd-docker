#
# Dockerfile for vlmcsd
#
FROM alpine
MAINTAINER test01wrk <test01wrk@gmail.com>

RUN apk add --update curl \
    && curl -sSL $(curl -sSL https://api.github.com/repos/Wind4/vlmcsd/releases/latest | grep browser_download_url \
        | sed -r 's/.*(https:.*binaries\.tar\.gz).*/\1/') -o binaries.tar.gz \
    && tar zxf binaries.tar.gz \
    && cp binaries/Linux/intel/static/vlmcsd-x86-musl-static /usr/bin/vlmcsd \
    && chmod 0755 /usr/bin/vlmcsd \
    && rm -rf binaries/ binaries.tar.gz \
    && rm -rf /var/cache/apk/*

EXPOSE 1688

ENTRYPOINT ["/usr/bin/vlmcsd", "-D", "-e"]