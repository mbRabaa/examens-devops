# Utilise une image de base avec Java 17
FROM openjdk:17-jdk-slim

# Spécifie le dossier de travail dans le conteneur
WORKDIR /app

# Copie le fichier JAR généré lors du build Maven dans le conteneur
# Remarquez que le chemin du fichier JAR doit correspondre à la sortie réelle de votre build Maven.
COPY target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

# Expose le port sur lequel l'application Spring Boot écoute
EXPOSE 8888

# Commande pour démarrer l'application Spring Boot
ENTRYPOINT ["java", "-jar", "/app/demo.jar"]
