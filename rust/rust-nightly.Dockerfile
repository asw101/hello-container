FROM rust:latest 

RUN rustup update nightly \
    && rustup default nightly
