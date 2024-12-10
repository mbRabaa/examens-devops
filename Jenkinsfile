pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "mbrabaa2023/newspring"
        DOCKERHUB_CREDENTIALS = 'DockerHub'
        GITHUB_CREDENTIALS = 'github-credentials'
    }

    stages {
        stage('Cloner le code') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: GITHUB_CREDENTIALS, usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                        // Configurer un buffer plus grand pour Git
                        sh 'git config --global http.postBuffer 1048576000'  // 1 Go
                        sh 'git clone https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/mbRabaa/examens-devops.git'
                    }
                }
            }
        }

        stage('Construire le projet') {
            steps {
                script {
                    // Utiliser le wrapper Maven
                    sh './mvnw clean package'  // Utiliser le Maven Wrapper ici
                }
            }
        }

        stage('Construire l\'image Docker') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                    sh 'docker images'
                }
            }
        }

        stage('Pousser l\'image Docker sur Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                        sh 'docker push $DOCKER_IMAGE'
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}



