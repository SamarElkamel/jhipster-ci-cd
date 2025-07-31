# Dockerfile
FROM eclipse-temurin:17-jdk as builder
COPY target/*.jar app.jar

# Exécution de l'application
ENTRYPOINT ["java","-jar","/app.jar"]
