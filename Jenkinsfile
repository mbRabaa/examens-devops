node {
    def mvnHome = tool 'maven 3.5.2'
    def dockerImageTag = "mbrabaa2023/spring-app:${env.BUILD_NUMBER}"

    stage('Clone Repo') {
        git branch: 'main', url: 'https://github.com/mbRabaa/examens-devops.git'
    }

    stage('Build Project') {
        // Se déplacer dans le répertoire contenant le pom.xml
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

    stage('Push Docker Image to DockerHub') {
        echo "Pushing Docker image to DockerHub"
        sh "docker push ${dockerImageTag}"
    }
}
