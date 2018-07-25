pipeline {
  agent any
  stages {
    stage('init') {
      steps {
        withRvm {
          sh 'bundle install'
        }
      }
    }
  }
}

