pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Construire le projet') {
            steps {
                script {
                    // Définir le répertoire de travail correct
                    dir('/home/rabaa/springboot') {  // Remplacer par le chemin de votre projet
                        // S'assurer que le fichier mvnw est exécutable
                        sh 'chmod +x mvnw'
                        // Utiliser le wrapper Maven pour construire le projet
                        sh './mvnw clean package'  // Cette commande construit le projet sans ignorer les tests
                    }
                }
            }
        }

        stage('Construire l\'image Docker') {
            steps {
                script {
                    // Construire l'image Docker ici (si nécessaire)
                    sh 'docker build -t springboot-app .'
                }
            }
        }

        stage('Pousser l\'image Docker sur Docker Hub') {
            steps {
                script {
                    // Pousser l'image Docker sur Docker Hub (si nécessaire)
                    sh 'docker push springboot-app'
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()  // Nettoyer le workspace après l'exécution
        }
    }
}
