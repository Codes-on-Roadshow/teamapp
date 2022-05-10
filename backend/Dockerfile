FROM maven:3.8-openjdk-17 as builder

ADD . /
RUN ls
RUN mvn install package -q

FROM openjdk:17-alpine
WORKDIR /app
COPY --from=builder /target/teamapp-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]