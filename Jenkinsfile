pipeline {
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
                sh 'echo Building with Docker'
                sh 'docker build --tag=capstone .'
                sh 'docker image ls'
                sh 'echo Checking Files with LINT Completed'
             }
         }

	}
}
