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
                    sh 'rm -rf node_modules package-lock.json' // Clean frontend deps
                    sh 'mvn clean install'
                }
            }
        }

        stage('Test') {
            steps {
                sh 'mvn verify' // Runs unit + integration tests
            }
        }

        stage('Show Failsafe Errors (optional)') {
            steps {
                sh '''
                    if [ -d target/failsafe-reports ]; then
                        echo "======= Failsafe Report Output ======="
                        cat target/failsafe-reports/*.txt || true
                        echo "======= End Report ======="
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
            script {
                def surefire = findFiles(glob: 'target/surefire-reports/*.xml')
                def failsafe = findFiles(glob: 'target/failsafe-reports/*.xml')

                if (surefire.length > 0) {
                    junit 'target/surefire-reports/*.xml'
                }
                if (failsafe.length > 0) {
                    junit 'target/failsafe-reports/*.xml'
                }
                if (surefire.length == 0 && failsafe.length == 0) {
                    echo " Aucun fichier de test trouvé dans target/surefire-reports/ ni target/failsafe-reports/"
                }
            }
        }

        success {
            echo ' Pipeline terminé avec succès.'
        }

        failure {
            echo ' Le pipeline a échoué.'
        }
    }
}
