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
                mvn 'install'
            }
        }
        stage('Deployment') {
            steps {
                sh "cp target/tabletennis.war ${TOMCAT_HOME}/webapps"
            }
        }
        stage('Docker build') {
            steps {
                sh "docker build -t kunalsh/pipelineimage1 ."
            }
        }
        stage('Container creation') {
            steps {
                sh "docker run -it -d --name=container-pipeline kunalsh/pipelineimage1 /bin/bash"
            }
        }
    }
    post {
        failure {
            echo 'Pipeline failed!'
        }
    }
}
