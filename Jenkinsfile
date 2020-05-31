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
		stage('Build Docker Image') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker build -t 2002714/capstone:$BUILD_ID .
					'''
				}
			}
		}

		stage('Push Image To Dockerhub') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
						docker push 2002714/capstone:$BUILD_ID
					'''
				}
			}
		}
		stage('Set current kubectl context') {
			steps {
				withAWS(region:'us-west-2', credentials:'capstone') {
					sh '''
						kubectl config use-context arn:aws:eks:us-west-2:281958947511:cluster/prod
					'''
				}
			}
		}
        stage('Deploy the service') {
	        steps {
                withAWS(region:'us-west-2', credentials:'capstone') {
                    sh '''
                            kubectl apply -f ./blue-green-services.json
                    '''
                }
	        }
		}
		stage('Create blue container') {
			steps {
				withAWS(region:'us-west-2', credentials:'capstone') {
					sh '''
						kubectl run blueimage2 --image=2002714/capstone:$BUILD_ID --port=80
					'''
				}
			}
		}
		stage('Expose container') {
			steps {
				withAWS(region:'us-west-1', credentials:'capstone') {
					sh '''
						kubectl expose deployment blueimag2 --type=LoadBalancer --port=80
					'''
				}
			}
		}
        stage('Get service url') {
	        steps {
                withAWS(region:'us-west-2', credentials:'capstone') {
                    sh '''
                            kubectl get services
                    '''
                }
	        }
        }
	}
}
