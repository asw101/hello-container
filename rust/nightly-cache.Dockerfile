FROM rust:nightly as builder
# Choose a workdir
WORKDIR /usr/src/app
# Create blank project
RUN USER=root cargo init
# Copy Cargo.toml to get dependencies
COPY Cargo.toml .
# This is a dummy build to get the dependencies cached
RUN cargo build --release
# Copy sources
COPY src src
COPY *.toml ./
# Build app (bin will be in /usr/src/app/target/release/hello-rocket)
RUN cargo build --release

FROM debian:stretch-slim
# Copy bin from builder to this new image
COPY --from=builder /usr/src/app/target/release/hello-rocket /bin/
# Default command, run app
CMD hello-rocket
