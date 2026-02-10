# ========== Build stage: compile the Spring application ==========
FROM maven as build
WORKDIR /app
# Copy entire project source into the container
COPY . .
# Build the application and produce the JAR
RUN mvn install

# ========== Runtime stage: run the application ==========
FROM openjdk:11.0
WORKDIR /app
# Copy only the built JAR from the build stage (keeps final image small)
COPY --from=build /app/target/Uber.jar /app/
# Application listens on port 9000
EXPOSE 9000
# Start the Spring Boot application
CMD [ "java", "-jar", "Uber.jar" ]
