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
                sh 'echo Building with DOCKER'
                sh 'docker build --tag=capstone .'
                sh 'docker image ls'
                sh 'echo Building with DOCKER Completed'
             }
         }
         stage('Uploading Docker') {
             steps {
                sh 'echo Uploading to DOCKER'
                sh '''
                    dockerpath="2002714/app"
                    '''
                sh  '''
                    echo "Docker ID and Image: $dockerpath"
                '''
                sh 'docker login --username 2002714 --password-stdin < ~/mypassword'
                sh 'docker tag app:latest 2002714/capstone:latest'
                sh 'docker push 2002714/capstone:latest'
                sh 'echo Uploading to DOCKER Completed'
             }
         }

	}
}
