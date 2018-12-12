pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    disableConcurrentBuilds()
  }
  agent any
  environment {
    IMAGE_NAME          = "node"
    TEMP_IMAGE_NAME     = "node-build_${BUILD_NUMBER}"
    TEMP_IMAGE_NAME_ARM = "node-armhf-build_${BUILD_NUMBER}"
  }
  stages {
    stage('Build') {
      parallel {
        stage('x86_64') {
          steps {
            ansiColor('xterm') {
              sh 'docker build --pull --no-cache --squash --compress -t $TEMP_IMAGE_NAME .'
            }
          }
        }
        stage('armhf') {
          steps {
            ansiColor('xterm') {
              sh 'docker build --pull --no-cache --squash --compress -t $TEMP_IMAGE_NAME_ARM armhf/'
            }
          }
        }
      }
    }
    stage('Publish') {
      steps {
        ansiColor('xterm') {
          // Public
          sh 'docker tag $TEMP_IMAGE_NAME docker.io/jc21/$IMAGE_NAME:latest'
          sh 'docker tag $TEMP_IMAGE_NAME_ARM docker.io/$IMAGE_NAME:armhf'
          withCredentials([usernamePassword(credentialsId: 'jc21-dockerhub', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
            sh "docker login -u '${duser}' -p '$dpass'"
            sh 'docker push docker.io/jc21/$IMAGE_NAME:latest'
            sh 'docker push docker.io/jc21/$IMAGE_NAME:armhf'
          } 

          // Private
          sh 'docker tag $TEMP_IMAGE_NAME $DOCKER_PRIVATE_REGISTRY/$IMAGE_NAME:latest'
          sh 'docker tag $TEMP_IMAGE_NAME_ARM $DOCKER_PRIVATE_REGISTRY/$IMAGE_NAME:armhf'
          withCredentials([usernamePassword(credentialsId: 'jc21-private-registry', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
            sh "docker login -u '${duser}' -p '$dpass' $DOCKER_PRIVATE_REGISTRY"
            sh 'docker push $DOCKER_PRIVATE_REGISTRY/$IMAGE_NAME:latest'
            sh 'docker push $DOCKER_PRIVATE_REGISTRY/$IMAGE_NAME:armhf'
          }
        }
      }
    }
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
      sh 'docker rmi $TEMP_IMAGE_NAME $TEMP_IMAGE_NAME_ARM'
    }
  }
}

