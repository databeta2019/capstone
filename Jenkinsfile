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
						docker build -t 2002714/capstone:lastest .
					'''
				}
			}
		}

		stage('Push Image To Dockerhub') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
						docker push 2002714/capstone:lastest
					'''
				}
			}
		}
		stage('Set current kubectl context') {
			steps {
				withAWS(region:'us-west-2', credentials:'capstone') {
					sh '''
						kubectl config use-context arn:aws:eks:us-west-2:281958947511:cluster/prod2
					'''
				}
			}
		}
        stage('Create Blue Controller') {
            steps{
                withAWS(region:'us-west-2',credentials:'capstone') {
					withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
	                    sh '''
							docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
							docker ps -a
	                    	kubectl get pods
	                    	kubectl get deployments
	                    	kubectl get nodes
							kubectl set image deployments/bluetype2 capstone=2002714/capstone:latest
  	                    	kubectl apply -f ./blue-controller.json
	                    	kubectl get pods
	                    	kubectl get deployments
	                    	kubectl get nodes
							docker ps -a
	                    '''
					}
                }
            }
        }
        stage('Deploy the service') {
	        steps {
                withAWS(region:'us-west-2', credentials:'capstone') {
                    sh '''
                            kubectl apply -f ./blue-green-services.json
	                    	kubectl get pods
	                    	kubectl get deployments
	                    	kubectl get nodes
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
