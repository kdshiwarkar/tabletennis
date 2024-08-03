pipeline {
	agent any
        stages {
            stage('Checkout') {
        steps {
		checkout scm			       
	      }}
	stage('Build') {
           steps {
		  sh '/home/kunalshiwarkar/Documents/Devops_software/tar/apache-maven-3.9.7/bin/mvn install'
                 }}
	stage('Deployment'){
	    steps {
		sh 'cp target/tabletennis.war /home/kunalshiwarkar/Documents/Devops_software/tar/apache-tomcat-9.0.89/webapps'
		}}
		stage('Docker build'){
	    steps {
		sh 'docker build -t kunalsh/containerpipe2 .'
		}}
       
		stage('Container creation'){
	    steps {
		sh 'docker run -dit --name=containerpipeline kunalsh/containerpipe2 /bin/bash'
		}}
		stage('Build') {
           steps {
		  sh '/opt/download/extract/maven/apache-maven-3.9.8/bin/mvn install'
                 }}
		stage('Deployment'){
	    steps {
		sh 'cp target/tabletennis.war /opt/download/extract/tomcat/apache-tomcat-9.0.91/webapps'
		}}
	}}		
