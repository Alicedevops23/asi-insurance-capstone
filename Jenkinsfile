pipeline {

  agent any

  stages {

    stage("Build") {

      steps {

        script {

          docker.build("my-app")

        }

      }

    }

    stage("Deploy") {

      steps {

        script {

          docker.withRegistry("", "dockerhub") {

            docker.image("my-app").push("latest")

          }

        }

      }

    }

  }

}


