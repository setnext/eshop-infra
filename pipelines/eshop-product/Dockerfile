FROM maven:3.8.1-openjdk-17 AS maven
LABEL MAINTAINER="nithya@setnext.io"

WORKDIR /usr/src/app
COPY . /usr/src/app
# Compile and package the application to an executable JAR
RUN mvn package

# For Java 17,Slim Java Version
FROM openjdk:17-jdk-slim-buster

ARG JAR_FILE=com.setnext.eshop.products.jar
WORKDIR /opt/app

# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/

ENTRYPOINT ["java","-jar","com.setnext.eshop.products.jar"]
