pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'mvn install'
            }
        }
        stage('Deployment') {
            steps {
                sh 'cp target/tabletennis.war /home/kunalshiwarkar/Documents/Devops_software/tar/apache-tomcat-9.0.89/webapps'
            }
        }
        stage('docker build') {
            steps {
                sh 'docker build --no-cache -t kunalsh/kunal_container .'
            }
        }
        stage('Container creation') {
            steps {
                sh 'docker run -it -d --name=container2404 kunalsh/kunal_container /bin/bash'
            }
        }
        stage('Login to Docker') {
            steps {
                // Login to Docker using credentials from Jenkins credentials store
                withCredentials([usernamePassword(credentialsId: 'docker-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'docker login -u ${kunalsh} -p ${Kunnu@2404}'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                sh 'docker push ${kunalsh}/kunal_container'
            }
        }
    }
}
