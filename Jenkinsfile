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
                sh './mvnw clean compile'
            }
        }

        stage('Test Backend') {
            steps {
                echo 'Running backend tests...'
                sh './mvnw test'
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

        stage('Test Frontend') {
            when {
                expression { fileExists('src/main/webapp/jest.config.js') || fileExists('src/main/webapp/karma.conf.js') }
            }
            steps {
                dir('src/main/webapp') {
                    echo 'Running frontend tests...'
                    sh 'npm test'
                }
            }
        }

    
        stage('Install Snyk') {
            steps {
                sh 'npm install snyk'
            }
        }

        
        stage('Snyk Auth') {
            steps {
                withCredentials([string(credentialsId: 'SNYK_TOKEN', variable: 'SNYK_TOKEN')]) {
                    sh 'snyk auth $SNYK_TOKEN'
                }
            }
        }

       
        stage('Snyk Test Backend') {
            steps {
                sh 'npx snyk test --all-projects'
            }
        }

        stage('Snyk Test Frontend') {
            steps {
                dir('src/main/webapp') {
                    sh 'snyk test'
                }
            }
        }

    
        stage('SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'ac0e0675-2d99-477d-9e66-7e52d5f62932', variable: 'SONAR_TOKEN')]) {
                    sh """
                      mvn sonar:sonar \\
                      -Dsonar.projectKey=testdb \\
                      -Dsonar.host.url=http://localhost:9000 \\
                      -Dsonar.login=$SONAR_TOKEN \\
                      -X
                    """
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
