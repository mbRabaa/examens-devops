pipeline {
    agent any
    environment {
        GITHUB_CREDENTIALS = credentials('github-credentials')  // Remplace 'github-credentials' par l'ID de tes credentials GitHub
        DOCKER_HUB_CREDENTIALS = credentials('DockerHub')  // Remplace 'DockerHub' par l'ID de tes credentials Docker Hub
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout du code depuis GitHub avec les credentials
                git credentialsId: 'github-credentials', url: 'https://github.com/mbRabaa/examens-devops.git'
            }
        }
        stage('Build & Docker Image') {
            steps {
                script {
                    // Construire l'image Docker avec le nom spécifié
                    sh 'docker build -t mbrabaa2023/spring-img .'
                }
            }
        }
        stage('Login to Docker Hub') {
            steps {
                script {
                    // Connexion à Docker Hub avec les credentials
                    withDockerRegistry([credentialsId: 'DockerHub', url: 'https://index.docker.io/v1/']) {
                        echo "Connexion à Docker Hub réussie"
                    }
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Pousser l'image Docker vers Docker Hub
                    withDockerRegistry([credentialsId: 'DockerHub', url: 'https://index.docker.io/v1/']) {
                        sh 'docker push mbrabaa2023/spring-img'
                    }
                }
            }
        }
    }
}

modification de jenkinsfile
