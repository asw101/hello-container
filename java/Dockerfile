FROM maven:3.5.4-jdk-8 as builder
USER root
WORKDIR /home/app/
COPY . /home/app/
RUN mvn clean package
# ENTRYPOINT ["mvn", "clean", "thorntail:run"]

FROM openjdk:8-alpine
WORKDIR /home/
COPY --from=builder /home/app/target/demo-thorntail.jar /home/
ENTRYPOINT [ "java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/home/demo-thorntail.jar" ]
