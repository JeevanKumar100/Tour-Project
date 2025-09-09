pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/JeevanKumar100/Tour-Project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t tour-project .'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop old container if running
                    sh '''
                    docker stop tour_project_web || true
                    docker rm tour_project_web || true
                    docker run -d -p 8080:80 --name tour_project_web tour-project
                    '''
                }
            }
        }
    }
}
