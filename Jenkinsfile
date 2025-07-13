pipeline {
    agent any

    environment {
        CYPRESS_INSTALL_BINARY = '0'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/SamarElkamel/jhipster-ci-cd.git'
            }
        }

        stage('Build') {
            steps {
                sh 'echo "cypress_skip_binary_install=true" >> .npmrc'
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                sh 'echo "Tests here..."'
            }
        }

        stage('Deploy') {
            steps {
                sh 'echo "Deploy stage..."'
            }
        }
    }

    post {
        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}
