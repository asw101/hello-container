FROM rust:latest as builder
RUN rustup update nightly \
    && rustup default nightly
WORKDIR /app
COPY . .
RUN cargo build --release 
# bin will be in /app/target/release/hello-rocket

FROM debian:stretch-slim
WORKDIR /app
COPY --from=builder /app/target/release/hello-rocket ./
CMD ["./hello-rocket"]
