FROM openjdk:17-alpine
WORKDIR /app
ADD . .
RUN ./mvnw package -DskipTests
ENTRYPOINT ["java","-jar","./target/teamapp-0.0.1-SNAPSHOT.jar"]