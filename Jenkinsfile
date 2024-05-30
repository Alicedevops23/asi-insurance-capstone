pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    // Tag the image with your Docker Hub username
                    docker.build('alicedockerhub/my-app')
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        // Push the image with your Docker Hub username
                        docker.image('alicedockerhub/my-app').push('latest')
                    }
                }
            }
        }
    }
}
