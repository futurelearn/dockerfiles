FROM ubuntu:18.04

RUN apt-get update && \
  apt-get install -y clamav-daemon

COPY clamd.conf /etc/clamav/clamd.conf

RUN mkdir -p /var/lib/clamav && \
  chown -R clamav:clamav /var/lib/clamav && \
  freshclam --on-error-execute freshclam --no-dns

EXPOSE 3310

CMD ["clamd"]
