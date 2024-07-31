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
                sh '/home/kunalshiwarkar/Documents/Devops_software/tar/apache-maven-3.9.7/bin/mvn install'
            }
        }
        stage('Deployment') {
            steps {
                sh 'cp target/tabletennis.war /home/kunalshiwarkar/Documents/Devops_software/tar/apache-tomcat-9.0.89/webapps'
            }
        }
        stage('Docker build') {
            steps {
                docker.build('kunalsh/imagepipe', '.')
            }
        }
        stage('Container creation') {
            steps {
                docker.run('kunalsh/imagepipe', '/bin/bash')
            }
        }
    }
}
