pipeline {
    agent any

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
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        docker.image('alicedockerhub/my-app').push('latest')
                    }
                }
                sshagent(['ec2-ssh-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@107.20.102.203 << EOF
                        docker pull alicedockerhub/my-app:latest
                        docker stop my-app || true
                        docker rm my-app || true
                        docker run -d --name my-app -p 80:80 alicedockerhub/my-app:latest
                        EOF
                    '''
                }
            }
        }
    }
}
