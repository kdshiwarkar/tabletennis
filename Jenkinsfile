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
                dir('docker') {
                    sh 'docker build -t kunalsh/kunal_container .'
                }
            }
        }
        stage('Container creation') {
            steps {
                sh 'docker run -it -d --name=container2404 kunalsh/kunal_container /bin/bash'
            }
        }
        stage('Build and Deploy project') {
            steps {
                sh 'docker exec -it container2404 /opt/download/apache-maven-3.9.8/bin/mvn install'
                sh 'docker exec -it container2404 cp target/tabletennis.war /opt/download/apache-tomcat-9.0.91/webapps'
            }
        }
    }
}
