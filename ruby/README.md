# ruby

clone repo
```
git clone https://github.com/Azure-Samples/ruby-docs-hello-world
```

docker run
```
cd ruby-docs-hello-world/
docker run --rm -v $(pwd):/pwd/ -w /pwd/ -p 8080:3000 -it ruby bash
apt-get update && apt-get install -y nodejs
bundle install
bundle exec rails server
# open http://localhost:8080
```

docker build
```
cd ruby-docs-hello-world/
docker build -f ../Dockerfile -t hello-ruby .
docker run --rm -it -p 8080:3000 hello-ruby
```

# resources

- https://docs.microsoft.com/en-us/azure/app-service/containers/quickstart-ruby
- https://docs.docker.com/compose/rails/
- https://hub.docker.com/r/bitnami/ruby-example/
