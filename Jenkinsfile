pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    disableConcurrentBuilds()
  }
  agent any
  environment {
    IMAGE_NAME      = "node"
    TEMP_IMAGE_NAME = "node-build_${BUILD_NUMBER}"
  }
  stages {
    stage('Prepare') {
      steps {
        sh 'docker pull docker.io/node:9-slim'
      }
    }
    stage('Build') {
      steps {
        sh 'docker build --squash --compress -t $TEMP_IMAGE_NAME .'
      }
    }
    stage('Publish') {
      steps {
        sh 'docker tag $TEMP_IMAGE_NAME $DOCKER_PRIVATE_REGISTRY/$IMAGE_NAME:latest'
        sh 'docker push $DOCKER_PRIVATE_REGISTRY/$IMAGE_NAME:latest'
      }
    }
  }
  triggers {
    bitbucketPush()
  }
  post {
    success {
      juxtapose event: 'success'
      sh 'figlet "SUCCESS"'
    }
    failure {
      juxtapose event: 'failure'
      sh 'figlet "FAILURE"'
    }
    always {
      sh 'docker rmi $TEMP_IMAGE_NAME'
    }
  }
}
