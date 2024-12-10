# Utilise une image de base avec Java
FROM openjdk:17-jdk-slim

# Spécifie le dossier de travail
WORKDIR /app

# Copie le fichier JAR généré lors du build Maven
COPY target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

# Expose le port sur lequel l'application Spring Boot écoute
EXPOSE 8888

# Commande pour démarrer l'application Spring Boot
ENTRYPOINT ["java", "-jar", "/app/demo.jar"]
