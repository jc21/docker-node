pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    disableConcurrentBuilds()
  }
  agent any
  environment {
    IMAGE          = "node"
    TEMP_IMAGE     = "node-build_${BUILD_NUMBER}"
    PUBLIC_LATEST  = "docker.io/jc21/${IMAGE}:latest"
    PRIVATE_LATEST = "docker.jc21.net.au/jcurnow/${IMAGE}:latest"
    // Architectures:
    AMD64_TAG        = "amd64"
    ARMV6_TAG        = "armv6l"
    ARMV7_TAG        = "armv7l"
    ARM64_TAG        = "arm64"
  }
  stages {
    stage('Build Master') {
      when {
        branch 'master'
      }
      // ========================
      // amd64
      // ========================
      parallel {
        stage('amd64') {
          agent {
            label 'amd64'
          }
          steps {
            ansiColor('xterm') {
              // Docker Build
              sh 'docker build --pull --no-cache --squash --compress -t ${TEMP_IMAGE}-${AMD64_TAG} .'

              // Dockerhub
              sh 'docker tag ${TEMP_IMAGE}-${AMD64_TAG} ${PUBLIC_LATEST}'
              withCredentials([usernamePassword(credentialsId: 'jc21-dockerhub', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
                sh "docker login -u '${duser}' -p '${dpass}'"
                sh 'docker push ${PUBLIC_LATEST}'
                sh 'docker rmi ${PUBLIC_LATEST}'
              }

              // Private
              sh 'docker tag ${TEMP_IMAGE}-${AMD64_TAG} ${PRIVATE_LATEST}'
              withCredentials([usernamePassword(credentialsId: 'jc21-private-registry', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
                sh "docker login -u '${duser}' -p '${dpass}' docker.jc21.net.au"
                sh 'docker push ${PRIVATE_LATEST}'
                sh 'docker rmi ${PRIVATE_LATEST}'
              }

              sh 'docker rmi ${TEMP_IMAGE}-${AMD64_TAG}'
            }
          }
        }
        // ========================
        // arm64
        // ========================
        stage('arm64') {
          agent {
            label 'arm64'
          }
          steps {
            ansiColor('xterm') {
              // Docker Build
              sh 'docker build --pull --no-cache --squash --compress -t ${TEMP_IMAGE}-${ARM64_TAG} -f Dockerfile.${ARM64_TAG} .'

              // Dockerhub
              sh 'docker tag ${TEMP_IMAGE}-${ARM64_TAG} ${PUBLIC_LATEST}-${ARM64_TAG}'
              withCredentials([usernamePassword(credentialsId: 'jc21-dockerhub', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
                sh "docker login -u '${duser}' -p '${dpass}'"
                sh 'docker push ${PUBLIC_LATEST}-${ARM64_TAG}'
                sh 'docker rmi ${PUBLIC_LATEST}-${ARM64_TAG}'
              }

              // Private
              sh 'docker tag ${TEMP_IMAGE}-${ARM64_TAG} ${PRIVATE_LATEST}-${ARM64_TAG}'
              withCredentials([usernamePassword(credentialsId: 'jc21-private-registry', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
                sh "docker login -u '${duser}' -p '${dpass}' docker.jc21.net.au"
                sh 'docker push ${PRIVATE_LATEST}-${ARM64_TAG}'
                sh 'docker rmi ${PRIVATE_LATEST}-${ARM64_TAG}'
              }

              sh 'docker rmi ${TEMP_IMAGE}-${ARM64_TAG}'
            }
          }
        }
        // ========================
        // armv7l
        // ========================
        stage('armv7l') {
          agent {
            label 'armv7l'
          }
          steps {
            ansiColor('xterm') {
              // Docker Build
              sh 'docker build --pull --no-cache --squash --compress -t ${TEMP_IMAGE}-${ARMV7_TAG} -f Dockerfile.${ARMV7_TAG} .'

              // Dockerhub
              sh 'docker tag ${TEMP_IMAGE}-${ARMV7_TAG} ${PUBLIC_LATEST}-${ARMV7_TAG}'
              withCredentials([usernamePassword(credentialsId: 'jc21-dockerhub', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
                sh "docker login -u '${duser}' -p '${dpass}'"
                sh 'docker push ${PUBLIC_LATEST}-${ARMV7_TAG}'
                sh 'docker rmi ${PUBLIC_LATEST}-${ARMV7_TAG}'
              }

              // Private
              sh 'docker tag ${TEMP_IMAGE}-${ARMV7_TAG} ${PRIVATE_LATEST}-${ARMV7_TAG}'
              withCredentials([usernamePassword(credentialsId: 'jc21-private-registry', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
                sh "docker login -u '${duser}' -p '${dpass}' docker.jc21.net.au"
                sh 'docker push ${PRIVATE_LATEST}-${ARMV7_TAG}'
                sh 'docker rmi ${PRIVATE_LATEST}-${ARMV7_TAG}'
              }

              sh 'docker rmi ${TEMP_IMAGE}-${ARMV7_TAG}'
            }
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
  }
}
