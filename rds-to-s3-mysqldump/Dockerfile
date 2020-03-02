FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /opt

RUN apt-get update && \
  apt-get install -y \
  curl \
  default-mysql-client \
  pigz \
  zip \
  && apt-get clean

RUN curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
  -o "awscliv2.zip" && \
  unzip -q "awscliv2.zip" && \
  ./aws/install && \
  rm -f awscliv2.zip && \
  rm -rf aws

COPY run.sh /usr/bin/rds-to-s3-mysqldump
RUN chmod +x /usr/bin/rds-to-s3-mysqldump

RUN mkdir -p -m 0550 /usr/share/ca-certificates/aws/rds
COPY certs/*.pem /usr/share/ca-certificates/aws/rds/
RUN chmod 0440 /usr/share/ca-certificates/aws/rds/*.pem

CMD ["/usr/bin/rds-to-s3-mysqldump"]
