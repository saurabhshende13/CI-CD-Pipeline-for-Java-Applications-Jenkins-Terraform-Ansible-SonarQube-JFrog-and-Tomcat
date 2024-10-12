pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git url: "${GIT_REPO}", branch: 'main'
            }
        }
    }
}