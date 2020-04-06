FROM ubuntu:18.04

RUN apt-get update && \
  apt-get install -y clamav-daemon netcat

COPY clamd.conf /etc/clamav/clamd.conf

RUN mkdir -p /var/lib/clamav && \
  chown -R clamav:clamav /var/lib/clamav && \
  freshclam --on-error-execute freshclam --no-dns

EXPOSE 3310

HEALTHCHECK --interval=5s --timeout=5s --start-period=20s \
  CMD nc -vz localhost 3310 || exit 1

CMD ["clamd"]
