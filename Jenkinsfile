node {
    def mvnHome = tool 'maven 3.5.2'
    def dockerImageTag = "mbrabaa2023/spring-image:v1.0"

    stage('Clone Repo') {
        git branch: 'main', url: 'https://github.com/mbRabaa/examens-devops.git'
    }

    stage('Build Project') {
        sh "${mvnHome}/bin/mvn clean package"
    }

    stage('Build Docker Image') {
        sh "docker build -t ${dockerImageTag} ."
    }

    stage('Validate Docker Image') {
        sh "docker images | grep ${dockerImageTag}"
    }

    stage('Push Docker Image to DockerHub') {
        withCredentials([usernamePassword(credentialsId: 'DockerHub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
            sh "docker push ${dockerImageTag}"
        }
    }
}
