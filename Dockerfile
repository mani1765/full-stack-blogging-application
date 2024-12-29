#FROM eclipse-temurin:17-jdk-alpine
    
#EXPOSE 8080
 
#ENV APP_HOME /usr/src/app

#COPY target/*.jar $APP_HOME/app.jar

#WORKDIR $APP_HOME

#CMD ["java", "-jar", "app.jar"]
#===================================
# Use the official OpenJDK image as the base image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the local jar file (make sure you have built it first) to the container's working directory
# Adjust the path to your actual .jar file location
COPY target/twitter-app-0.0.3.jar /app/twitter-app-0.0.3.jar

# Expose the port that the app will be running on
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "/app/twitter-app-0.0.3.jar"]
