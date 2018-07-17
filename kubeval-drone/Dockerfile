FROM alpine:latest

ENV KUBEVAL_VERSION=0.7.1

RUN apk add --no-cache bash curl

RUN curl -L https://github.com/garethr/kubeval/releases/download/$KUBEVAL_VERSION/kubeval-linux-amd64.tar.gz | tar zxv && \
    chmod +x kubeval && \
    mv kubeval /bin/kubeval

COPY kubeval-dir /bin/kubeval-dir

ENTRYPOINT ["/bin/kubeval-dir"]
