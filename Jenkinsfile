pipeline {
  agent any
  agent {
    docker { image 'ruby:2.5.0' }
  }
  stages {
    stage('init') {
      steps {
        sh 'bundle install'
      }
    }
  }
}

