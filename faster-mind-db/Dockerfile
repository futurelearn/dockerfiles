FROM ruby:2.5

ENV RUSTUP_HOME=/usr/local/rustup \
  CARGO_HOME=/usr/local/cargo \
  PATH=/usr/local/cargo/bin:$PATH

RUN apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates gcc libc6-dev wget

RUN wget https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init && \
  chmod u+x rustup-init && \
  ./rustup-init -y --no-modify-path --default-toolchain stable && \
  chmod -R a+w $RUSTUP_HOME $CARGO_HOME

CMD cargo
