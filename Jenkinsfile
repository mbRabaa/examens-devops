node {
    def mvnHome = tool 'maven 3.5.2'
    def dockerImageTag = "mbrabaa2023/spring-image:${env.BUILD_NUMBER}"

    stage('Clone Repo') {
        git branch: 'main', url: 'https://github.com/mbRabaa/examens-devops.git'
    }

   // stage('Build Project') {
       // sh "mvn clean package"
   // }

   stage('Build Docker Image') {
       sh "docker build -t mbrabaa2023/spring-image:01 ."
   }

    stage('Push Docker Image to DockerHub') {
        withCredentials([usernamePassword(credentialsId: 'DockerHub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
            sh "docker push mbrabaa2023/spring-image:01"
        }
    }
}

        

modification de jenkinsfiles
