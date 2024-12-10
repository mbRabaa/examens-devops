node {
    def mvnHome = tool 'maven-3.5.2'
    def dockerImage
    def dockerImageTag = "mbrabaa2023/spring-app:${env.BUILD_NUMBER}"
    def containerName = "spring-app-container"
    def hostPort = 2223 // Changer le port si nécessaire

    stage('Clone Repo') {
        git branch: 'main', url: 'https://github.com/mbRabaa/examens-devops.git'
    }

    stage('Build Project') {
        dir('springboot') {
            sh "mvn clean package"
        }
    }

    stage('Login to DockerHub') {
        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
        }
    }

    stage('Build Docker Image') {
        sh "docker build -t ${dockerImageTag} ."
    }

    stage('Deploy Docker Image') {
        echo "Docker Image Tag Name: ${dockerImageTag}"

        // Arrêter et supprimer tout ancien conteneur avec le même nom
        sh """
        docker ps -a | grep ${containerName} && docker stop ${containerName} && docker rm ${containerName} || echo 'No container to remove'
        """

        // Lancer le conteneur
        sh "docker run --name ${containerName} -d -p ${hostPort}:2222 ${dockerImageTag}"
    }

    stage('Push Docker Image to DockerHub') {
        echo "Pushing Docker image to DockerHub"
        sh "docker push ${dockerImageTag}"
    }
}

