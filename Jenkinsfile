pipeline {
  agent any
  stages {
    stage('init') {
      steps {
        withRvm('ruby-2.3.1') {
            sh 'ruby --version'
            sh 'gem install rake'
        }
      }
    }
  }
}

