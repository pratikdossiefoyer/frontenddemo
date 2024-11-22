pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'react-app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Code Quality') {
            steps {
                sh 'npm run lint || true'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test -- --watchAll=false || true'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh """
                        docker stop ${DOCKER_IMAGE} || true
                        docker rm ${DOCKER_IMAGE} || true
                        docker run -d -p 80:80 --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}