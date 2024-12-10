pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/springboot-app'
        DOCKER_CREDENTIALS = 'docker-credentials'  // Remplacez par votre ID de credentials Docker dans Jenkins
        GITHUB_CREDENTIALS = 'github-credentials'  // Remplacez par vos credentials GitHub
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Vérification du code source depuis le dépôt GitHub
                checkout scm
            }
        }

        stage('Verify Directory') {
            steps {
                // Vérification du répertoire après checkout
                sh 'ls -la'
            }
        }

        stage('Build Maven Project') {
            steps {
                dir('springboot') {  // Assurez-vous que vous êtes dans le répertoire contenant le pom.xml
                    // Commande pour construire le projet avec Maven
                    sh './mvnw clean package -DskipTests'
                }
            }
        }

        stage('Verify JAR') {
            steps {
                // Vérification de la présence du fichier JAR après la construction
                sh 'ls -la target'
            }
        }

        stage('Build & Docker Image') {
            steps {
                dir('springboot') {  // Assurez-vous que vous êtes dans le bon répertoire
                    // Construction de l'image Docker
                    script {
                        def app = docker.build(DOCKER_IMAGE, '--build-arg JAR_FILE=target/*.jar .')
                    }
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                // Connexion à Docker Hub avec les credentials Jenkins
                script {
                    docker.withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // Pousser l'image Docker vers Docker Hub
                script {
                    docker.push(DOCKER_IMAGE)
                }
            }
        }
    }

    post {
        success {
            // Message en cas de succès
            echo 'Pipeline exécuté avec succès!'
        }
        failure {
            // Message en cas d'échec
            echo 'Le pipeline a échoué.'
        }
    }
}

        

modification de jenkinsfile
