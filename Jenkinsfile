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

		stage('Push git To Dockerhub') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
						docker push 2002714/capstone:lastest
					'''
				}
			}
		}
		stage('Create and Set current kubectl context') {
			steps {
				withAWS(region:'us-west-2', credentials:'capstone') {
					sh '''
						aws eks --region us-west-2 update-kubeconfig --name prod2
						kubectl config use-context arn:aws:eks:us-west-2:281958947511:cluster/prod2
					'''
				}
			}
		}
        stage('Deploy the service') {
                steps {
                        withAWS(region:'us-east-2', credentials:'capstone') {
                                sh '''
                                        kubectl apply -f ./blue-green-services.json
                                '''
                        }
                }
        }
		stage('Deploy blue container') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone') {
					sh '''
						kubectl run blueimagecapstone --image=2002714/capstone:latest --port=80
					'''
				}
			}
		}


        stage('Get service url') {
	        steps {
                withAWS(region:'us-west-2', credentials:'capstone') {
                    sh '''
                            kubectl get services
                            kubectl get pods
                            kubeconfig get nodes
                            kubectl get deployments
                    '''
                }
	        }
        }
	}
}
