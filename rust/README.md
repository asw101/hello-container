# rust

## rocket

clone repos and see examples
```
git clone git@github.com:SergioBenitez/Rocket.git
# see: Rocket/examples/hello_world/
```

docker run
```
docker build -f rust-nightly.Dockerfile -t rust:nightly rust-nightly/
docker run --rm -v $(pwd):/pwd/ -w /pwd/ -p 8080:8000 -it rust:nightly bash
# docker run --rm -v $(pwd):/pwd/ -w /pwd/ -p 8080:8000 -it rust:latest bash
# rustup update nightly; rustup default nightly;
cd /pwd/hello-rocket/ 
cargo run
# open http://localhost:8080
```

docker build
```
cd hello-rocket/
docker build -f ../nightly.Dockerfile -t hello-rust .
docker run --rm -p 8080:8000 -it hello-rust
```

## hyper

clone repos and see examples
```
git clone git@github.com:hyperium/hyper.git
# see: hyper/examples/hello.rs 
```

docker run
```
docker run --rm -v $(pwd):/pwd/ -w /pwd/ -p 8080:3000 -it rust:latest bash
cd hello-hyper/
cargo run
# open http://localhost:8080
```

docker build
```
cd hello-hyper/
docker build -f ../Dockerfile -t hello-rust .
docker run --rm -p 8080:3000 -it hello-rust
```

# resources

- https://github.com/SergioBenitez/Rocket/tree/v0.4/examples/hello_world
- https://hyper.rs/guides/server/hello-world/
- https://api.rocket.rs/v0.3/rocket/config/
- https://blog.jawg.io/docker-multi-stage-build/
