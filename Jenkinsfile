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
                sh 'docker build -t kunalsh/kunal_container .'
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
                    sh 'docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                // Push Docker image to Docker Hub
                sh 'docker tag kunalsh/kunal_container ${DOCKER_USERNAME}/kunal_container24:latest'
                sh 'docker push ${DOCKER_USERNAME}/kunal_container24:latest'
            }
        }
    }
}
