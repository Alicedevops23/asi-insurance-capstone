pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub') // Docker Hub credentials
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
                    withDockerRegistry([credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/']) {
                        docker.image('alicedockerhub/my-app').push('latest')
                    }
                }
                sshagent(['ec2-ssh-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@107.20.102.203 'docker pull alicedockerhub/my-app:latest'
                    ssh -o StrictHostKeyChecking=no ubuntu@107.20.102.203 'docker stop my-app || true'
                    ssh -o StrictHostKeyChecking=no ubuntu@107.20.102.203 'docker rm my-app || true'
                    ssh -o StrictHostKeyChecking=no ubuntu@107.20.102.203 'docker run -d --name my-app -p 8082:80 alicedockerhub/my-app:latest'
                    '''
                }
            }
        }
    }
}
