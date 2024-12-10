pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "mbrabaa2023/newspring"
        DOCKERHUB_CREDENTIALS = 'DockerHub'
        GITHUB_CREDENTIALS = 'github-credentials'
    }

    stages {
        stage('Préparer l\'environnement') {
            steps {
                echo 'Le code a déjà été cloné automatiquement par Jenkins.'
            }
        }

        stage('Construire le projet') {
            steps {
                script {
                    sh './mvnw clean package -DskipTests'
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
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                        sh 'docker push $DOCKER_IMAGE'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Nettoyage du workspace...'
            cleanWs()
        }
        success {
            echo 'Pipeline terminé avec succès.'
        }
        failure {
            echo 'Pipeline échoué. Veuillez vérifier les logs pour plus de détails.'
        }
    }
}




