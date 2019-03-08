# kotlin

docker run
```
docker run --rm -v $(pwd):/pwd/ -w /pwd/ -p 8080:8080 -it gradle:jdk8 bash
gradle clean jar
java -jar build/libs/blog-1.0-SNAPSHOT.jar
```

docker build
```
docker build -t hello-kotlin .
docker run --rm -p 8080:8080 -it hello-kotlin
```

# resources

- https://ktor.io/
- https://ktor.io/servers/configuration.html#command-line
