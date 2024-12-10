pipeline {
    agent any  // Utilise n'importe quel agent Jenkins disponible

    environment {
        DOCKER_IMAGE = "mbrabaa2023/newspring"  // Nom de l'image Docker
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials'  // Credentials Docker Hub enregistrés dans Jenkins
        GITHUB_CREDENTIALS = 'github-credentials'  // Credentials GitHub enregistrés dans Jenkins
    }

    stages {
        stage('Cloner le code') {
            steps {
                // Cloner le code depuis GitHub en utilisant les credentials GitHub
                git credentialsId: GITHUB_CREDENTIALS, url: 'https://github.com/mbRabaa/examens-devops.git'
            }
        }

        stage('Construire le projet') {
            steps {
                // Construire l'application Spring Boot avec Maven
                script {
                    sh './mvnw clean package -DskipTests'  // Utilise Maven Wrapper ou Maven si installé
                }
            }
        }

        stage('Construire l\'image Docker') {
            steps {
                script {
                    // Construire l'image Docker avec le Dockerfile
                    sh 'docker build -t $DOCKER_IMAGE .'
                    // Vérifier si l'image Docker a bien été construite
                    sh 'docker images'
                }
            }
        }

        stage('Pousser l\'image Docker sur Docker Hub') {
            steps {
                script {
                    // Se connecter à Docker Hub avec les identifiants Jenkins
                    withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"  // Se connecter à Docker Hub
                        // Pousser l'image sur Docker Hub
                        sh 'docker push $DOCKER_IMAGE'
                    }
                }
            }
        }
    }

    post {
        always {
            // Nettoyer les fichiers temporaires après le build
            cleanWs()
        }
    }
}

