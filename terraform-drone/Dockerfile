FROM ruby:2.5.5

ENV TF_VERSION=0.12.0

RUN apt-get update -qq && apt-get install -y zip

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
  unzip terraform_${TF_VERSION}_linux_amd64.zip && \
  mv terraform /usr/bin/terraform && \
  rm terraform_${TF_VERSION}_linux_amd64.zip
