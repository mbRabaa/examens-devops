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
                        // Cloner le dépôt avec les bonnes informations d'identification
                        sh '''
                            git config --global http.postBuffer 1048576000  # Augmenter la taille du buffer Git
                            git clone https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/mbRabaa/examens-devops.git .
                        '''
                    }
                }
            }
        }

        stage('Construire le projet') {
            steps {
                script {
                    // Validation pour s'assurer que mvnw est bien présent
                    sh '''
                        if [ ! -f "./mvnw" ]; then
                            echo "Erreur : mvnw introuvable ! Assurez-vous que le fichier mvnw est présent dans le répertoire."
                            exit 1
                        fi
                        ./mvnw clean package -DskipTests
                    '''
                }
            }
        }

        stage('Construire l\'image Docker') {
            steps {
                script {
                    // Vérifier si Dockerfile est présent avant de construire l'image
                    sh '''
                        if [ ! -f "./Dockerfile" ]; then
                            echo "Erreur : Dockerfile introuvable ! Assurez-vous que le fichier Dockerfile est dans le répertoire."
                            exit 1
                        fi
                        docker build -t $DOCKER_IMAGE .
                        docker images
                    '''
                }
            }
        }

        stage('Pousser l\'image Docker sur Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh '''
                            echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                            docker push $DOCKER_IMAGE
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            // Nettoyage de l'espace de travail pour éviter les conflits
            cleanWs()
        }
        failure {
            echo "Pipeline échoué. Veuillez vérifier les logs pour plus de détails."
        }
        success {
            echo "Pipeline exécuté avec succès !"
        }
    }
}



