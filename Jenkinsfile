pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'react-app'
        DOCKER_TAG = "${BUILD_NUMBER}"
        GITHUB_REPO = 'https://github.com/pratikdossiefoyer/frontenddemo.git'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: env.GITHUB_REPO
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test -- --passWithNoTests'
            }
        }

        stage('Build React App') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Push to Docker Hub') {
            environment {
                DOCKER_HUB_CREDS = credentials('docker-hub-credentials')
            }
            steps {
                script {
                    sh """
                        docker login -u ${DOCKER_HUB_CREDS_USR} -p ${DOCKER_HUB_CREDS_PSW}
                        docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh """
                        docker stop ${DOCKER_IMAGE} || true
                        docker rm ${DOCKER_IMAGE} || true
                        docker run -d -p 3000:80 --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
    }
}