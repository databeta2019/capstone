pipeline {
     environment {
         registry = "2002714/capstone"
         registryCredential = 'docker'
     }
     agent any
     stages {
         stage('Lint Python') {
             steps {
                sh 'echo Checking Files with LINT'
                sh 'tidy -q -e *.html'
                sh 'echo Checking Files with LINT Completed'
             }
         }
         stage('Build Docker') {
             steps {
                script {
                    docker.build registry + ":$BUILD_NUMBER"
                }
            }
         }
	}
}
