pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "tour-project"
        CONTAINER_NAME = "tour_project_web"
        HOST_PORT = "" // will be set dynamically
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

        stage('Select Free Port') {
            steps {
                script {
                    // Pick a free port starting from 8080
                    HOST_PORT = sh(script: "for p in {8080..8099}; do lsof -i:$p || echo $p; done | grep -E '^[0-9]{1,5}$' | head -n1", returnStdout: true).trim()
                    echo "Selected host port: ${HOST_PORT}"
                    env.HOST_PORT = HOST_PORT
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Running Docker container ${CONTAINER_NAME} on port ${HOST_PORT}"
                sh "docker run -d -p ${HOST_PORT}:80 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
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
            echo "Deployment completed successfully! Visit http://<YOUR_SERVER_IP>:${HOST_PORT}"
        }
        failure {
            echo "Deployment failed. Check the Jenkins console output for errors."
        }
    }
}
