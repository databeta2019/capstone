pipeline {
     agent any
     stages {
         stage('Lint Python') {
             steps {
                sh 'echo Checking Files with LINT'
                sh 'pip3 install --upgrade pip'
                sh 'pip3 install -r requirements.txt'
                sh 'pylint --disable=R,C,W1203,W1309 app.py'
                sh 'echo Checking Files with LINT Completed'
             }
         }
	}
}