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
                sh 'echo Building image with DCOKER'
                sh 'docker build -t 2002714/capstone:latest .'
                sh 'echo Building image with DCOKER Completed'
             }
         }
	}
}