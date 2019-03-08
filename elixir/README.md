# elixir

docker run
```
docker run --rm -v $(pwd):/pwd/ -w /pwd/ -p 8080:4000 -it elixir bash
# mix new . --sup --app simple_server
mix local.hex --force
mix deps.get
mix local.rebar --force

iex -S mix

# open http://localhost:8080
```

docker build
```
docker build -t hello-elixir .
docker run --rm -p 8080:4000 -it hello-elixir
```

# resources

- https://www.jungledisk.com/blog/2018/03/19/tutorial-a-simple-http-server-in-elixir/
