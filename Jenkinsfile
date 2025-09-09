pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "tour-project"
        CONTAINER_NAME = "tour_project_web"
        PORT = "8081" // Fixed host port
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/JeevanKumar100/Tour-Project.git'
            }
        }

        stage('Check Workspace') {
            steps {
                echo "Listing files in workspace:"
                sh 'pwd'
                sh 'ls -l'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image ${DOCKER_IMAGE}"
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Stop Existing Container') {
            steps {
                echo "Stopping existing container if it exists"
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Running Docker container ${CONTAINER_NAME} on port ${PORT}"
                sh "docker run -d -p ${PORT}:80 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
            }
        }

        stage('Clean Up Dangling Images') {
            steps {
                echo "Removing dangling Docker images"
                sh "docker image prune -f"
            }
        }
    }

    post {
        success {
            echo "Deployment completed successfully! Visit http://18.118.18.22:${PORT}"
        }
        failure {
            echo "Deployment failed. Check the Jenkins console output for errors."
        }
    }
}
