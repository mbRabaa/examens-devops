node {
    def mvnHome = tool 'maven 3.5.2'  // Utilisez la version de Maven que vous avez définie dans Jenkins
    def dockerImageTag = "spring-app:${env.BUILD_NUMBER}"  

    stage('Clone Repo') {
        git branch: 'main', url: 'https://github.com/mbRabaa/examens-devops.git'
    }

    stage('Build Project') {
        sh "mvn clean package"  
    }

    stage('Build Docker Image') {
        echo "Building Docker image with tag ${dockerImageTag}"
        // Construire l'image Docker avec le nom 'spring-app' et le tag basé sur le numéro de build
        sh "docker build -t ${dockerImageTag} ."
    }

    stage('Login to DockerHub') {
        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
        }
    }

    stage('Push Docker Image to DockerHub') {
        echo "Pushing Docker image to DockerHub with tag ${dockerImageTag}"
        // Pousser l'image Docker sur Docker Hub
        sh "docker push ${dockerImageTag}"
    }
}
