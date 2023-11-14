FROM gradle:7.6.2-jdk17-alpine AS build

COPY --chown=gradle:gradle . /home/gradle/src

WORKDIR /home/gradle/src

RUN gradle build 

FROM openjdk:17-jdk-slim

EXPOSE 8080

RUN mkdir /app 

COPY --from=build /home/gradle/src/demo_devops/gradle/wrapper/*.jar /app/spring-boot-application.jar

CMD ["java", "-jar", "app.jar"]
