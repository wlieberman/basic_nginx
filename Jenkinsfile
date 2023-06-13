IMAGE_REPOSITORY = "basic_nginx"
TARGET_CLUSTER_DOMAIN = "harbor.downstream.billylieberman.com"
pipeline {
    def docker_image

    stages{

        stage('Checkout') {
            agent {
                docker { image 'docker' }
            }
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Build') {
            docker_image = docker.build("basic_nginx.${env.BUILD_ID}")
        }

        stage('Unit Tests') {
            docker_image.inside {
                sh 'echo "Tests passed"'
            }
        }

        stage('Push') {
            docker.withRegistry(TARGET_CLUSTER['REGISTRY_URI'], TARGET_CLUSTER['REGISTRY_CREDENTIALS_ID']) {
                docker_image.push(IMAGE_TAG)
                docker_image.push("latest")
            }
        }

        stage('Deploy to Development') {}
        stage('Integration Tests') {}
        stage('Promote') {}
        stage('Deploy to Production') {}

    }
}

pipeline {
    agent {
        docker { image 'docker' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'echo "hello world!"'
            }
        }
    }
}