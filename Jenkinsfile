pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub') // Docker Hub credentials
        SSH_KEY = credentials('ec2-ssh-key') // SSH key credentials for EC2
    }

    stages {
        stage('Build') {
            steps {
                script {
                    docker.build('alicedockerhub/my-app')
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        docker.image('alicedockerhub/my-app').push('latest')
                    }
                }
                sshagent([SSH_KEY]) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@107.20.102.203 'docker pull alicedockerhub/my-app:latest'
                    ssh -o StrictHostKeyChecking=no ubuntu@107.20.102.203 'docker stop my-app || true'
                    ssh -o StrictHostKeyChecking=no ubuntu@107.20.102.203 'docker rm my-app || true'
                    ssh -o StrictHostKeyChecking=no ubuntu@107.20.102.203 'docker run -d --name my-app -p 80:80 alicedockerhub/my-app:latest'
                    '''
                }
            }
        }
    }
}
