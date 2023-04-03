FROM alpine:3.17.3 as base

FROM base as builder
COPY . /tmp
RUN apk add --no-cache make=4.3-r1
WORKDIR /tmp
RUN make install

FROM base
COPY --from=builder /usr/local/bin/* /usr/local/bin/
COPY --from=builder /usr/local/share/man/man1/* /usr/local/share/man/man1/
ENV MANPATH="/usr/local/share/man"
ENV PAGER="less"
RUN \
    apk add --no-cache bash=5.2.15-r0 git=2.38.4-r1 less=608-r1 mandoc=1.14.6-r6 man-pages=6.01-r0 perl-utils=5.36.0-r0 && \
    adduser -D user
USER user
WORKDIR /home/user
