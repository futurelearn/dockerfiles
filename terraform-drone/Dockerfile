FROM ruby:2.5.3

ENV TF_VERSION=0.11.10
ENV SOPS_VERSION=3.2.0

RUN apt-get update -qq && apt-get install -y zip parallel

# Install Sops
RUN wget https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops_${SOPS_VERSION}_amd64.deb && \
  dpkg -i sops_${SOPS_VERSION}_amd64.deb

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
  unzip terraform_${TF_VERSION}_linux_amd64.zip && \
  mv terraform /usr/bin/terraform && \
  rm terraform_${TF_VERSION}_linux_amd64.zip
