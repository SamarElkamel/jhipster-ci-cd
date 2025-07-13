pipeline {
    agent any

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'
        PATH = "${JAVA_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/SamarElkamel/jhipster-ci-cd.git'
            }
        }

        stage('Build Backend') {
            steps {
                sh './mvnw clean install -DskipTests'
            }
        }

        stage('Build Frontend') {
            steps {
                dir('src/main/webapp') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }
    }

    post {
        failure {
            echo 'Le pipeline a échoué.'
        }
        success {
            echo 'Le pipeline a réussi.'
        }
    }
}
