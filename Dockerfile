
# Use an official Gradle image as the base

FROM gradle:7.6.2-jdk17 AS build
 
# Set the working directory in the container

WORKDIR /app
 
# Copy the Gradle project files

COPY build.gradle settings.gradle /app/

COPY src /app/src
 
# Build the project using Gradle

RUN gradle build
 
# Use a lightweight image for the final deployment

FROM openjdk:17-jdk-slim
 
# Set the working directory

WORKDIR /app
 
# Copy the built artifacts from the previous stage

COPY --from=build /app/build/libs/*.jar app.jar
 
# Expose any ports required by your application

EXPOSE 8080
 
# Run your application (replace with the appropriate command)

CMD ["java", "-jar", "app.jar"]
