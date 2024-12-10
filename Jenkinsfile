pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Maven Project') {
            steps {
                script {
                    // Exécuter Maven pour construire le JAR
                    sh 'mvn clean package -DskipTests'
                }
            }
        }
        stage('Verify JAR') {
            steps {
                script {
                    // Vérifier que le fichier JAR est bien dans le répertoire target
                    sh 'ls -l target/'
                }
            }
        }
        stage('Build & Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    sh 'docker build -t mbrabaa2023/spring-img .'
                }
            }
        }
        stage('Login to Docker Hub') {
            steps {
                script {
                    // Se connecter à Docker Hub
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Pousser l'image Docker vers Docker Hub
                    sh 'docker push mbrabaa2023/spring-img'
                }
            }
        }
    }
}

modification de jenkinsfile
