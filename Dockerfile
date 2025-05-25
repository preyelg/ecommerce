# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Set app directory inside the container
WORKDIR /app

# Copy built jar into the container
COPY target/ecommerce-1.0-SNAPSHOT.jar app.jar

# Expose port used by Spring Boot
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
