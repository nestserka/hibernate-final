# Use an official Maven image as the base image
FROM maven:3.8.4-openjdk-11-slim AS build

WORKDIR /hibernate-final
COPY pom.xml .
COPY src ./src
RUN mvn dependency:copy-dependencies -DoutputDirectory=libs
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim
WORKDIR /hibernate-final
COPY --from=build /hibernate-final/target/hibernate-final-1.0-SNAPSHOT.jar .
COPY --from=build /hibernate-final/libs ./libs
CMD ["java", "-cp", "hibernate-final-1.0-SNAPSHOT.jar:libs/*", "org.example.Main"]