# java

docker run
```
docker run --rm -v $(pwd):/pwd/ -w /pwd/ -p 8080:8080 -it maven:3.5.4-jdk-8 bash
mvn clean package
mvn clean thorntail:run
# open http://localhost:8080
```

docker build
```
docker build -t hello-java .
docker run --rm -p 8080:8080 -it hello-java
```
