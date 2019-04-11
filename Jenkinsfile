pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    disableConcurrentBuilds()
  }
  agent any
  environment {
    IMAGE          = "node"
    TEMP_IMAGE     = "node-build_${BUILD_NUMBER}"
    TEMP_IMAGE_ARM = "node-armhf-build_${BUILD_NUMBER}"
    PRIVATE_LATEST = "docker.jc21.net.au/jcurnow/${IMAGE}:latest"
  }
  stages {
    stage('Build') {
      parallel {
        stage('x86_64') {
          steps {
            ansiColor('xterm') {
              sh 'docker build --pull --no-cache --squash --compress -t ${TEMP_IMAGE} .'
            }
          }
        }
//        stage('armhf') {
//          steps {
//            ansiColor('xterm') {
//              sh 'docker build --pull --no-cache --squash --compress -t ${TEMP_IMAGE_ARM} armhf/'
//            }
//          }
//        }
      }
    }
    stage('Publish') {
      steps {
        ansiColor('xterm') {
          // Dockerhub
          sh 'docker tag ${TEMP_IMAGE} docker.io/jc21/${IMAGE}:latest'
//          sh 'docker tag ${TEMP_IMAGE_ARM} docker.io/jc21/${IMAGE}:armhf'
          
          withCredentials([usernamePassword(credentialsId: 'jc21-dockerhub', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
            sh "docker login -u '${duser}' -p '${dpass}'"
            sh 'docker push docker.io/jc21/${IMAGE}:latest'
//            sh 'docker push docker.io/jc21/${IMAGE}:armhf'

            sh 'docker rmi docker.io/jc21/${IMAGE}:latest'
//            sh 'docker rmi docker.io/jc21/${IMAGE}:armhf'
          }

          // Private Registry
          sh 'docker tag ${TEMP_IMAGE} ${PRIVATE_LATEST}'
          withCredentials([usernamePassword(credentialsId: 'jc21-private-registry', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
            sh "docker login -u '${duser}' -p '${dpass}' docker.jc21.net.au"
            sh 'docker push ${PRIVATE_LATEST}'
            sh 'docker rmi ${PRIVATE_LATEST}'
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
      sh 'docker rmi ${TEMP_IMAGE}'
//      sh 'docker rmi ${TEMP_IMAGE_ARM}'
    }
  }
}

