FROM openjdk17:latest
COPY target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
