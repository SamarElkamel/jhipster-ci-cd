pipeline {
    agent any

    environment {
        MAVEN_HOME = '/usr/share/maven'
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'
        PATH = "${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/SamarElkamel/jhipster-ci-cd.git', branch: 'main'
            }
        }

        stage('Build Backend') {
            steps {
                sh 'chmod +x ./mvnw'
                sh './mvnw clean install -DskipTests'
            }
        }

        stage('Build Frontend') {
            steps {
                dir('src/main/webapp') {
                    withEnv([
                        "PATH=${env.WORKSPACE}/target/node:${env.WORKSPACE}/target/node/node_modules/npm/bin:${env.PATH}"
                    ]) {
                        sh 'npm install'
                        sh 'npm run webapp:build'
                    }
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
