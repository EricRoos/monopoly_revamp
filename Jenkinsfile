pipeline {
  agent any
  stages {
    stage('init') {
      steps {
        withRvm('2.5.0') {
          sh 'rvm use 2.5.0'
        }
      }
    }
  }
}

