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

        stage('Build') {
            steps {
                sh 'echo "CYPRESS_INSTALL_BINARY=0" >> .env'
                withEnv(['CYPRESS_INSTALL_BINARY=0']) {
                    sh 'rm -rf node_modules package-lock.json' 
                    sh 'mvn clean install'
                }
            }
        }

        stage('Test') {
            steps {
                sh 'mvn verify' 
            }
        }

        stage('Show test errors') {
            steps {
             
                sh '''
                    if [ -d target/failsafe-reports ]; then
                        echo "======= Failsafe Reports ======="
                        cat target/failsafe-reports/*.txt || true
                        echo "======= End Reports ======="
                    fi
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh 'echo "Déploiement fictif réussi."'
            }
        }
    }

    post {
        always {
           
            junit '**/target/failsafe-reports/*.xml'
        }
        success {
            echo 'Pipeline terminé avec succès.'
        }
        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}
