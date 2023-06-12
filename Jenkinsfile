IMAGE_REPOSITORY = "basic_nginx"
TARGET_CLUSTER_DOMAIN = "harbor.downstream.billylieberman.com"
node {
    def docker_image

    stage('Checkout') {
        checkout scm
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
        }
    }

    stage('Deploy to Development') {}
    stage('Integration Tests') {}
    stage('Promote') {}
    stage('Deploy to Production') {}

}

pipeline {
    agent {
        docker { image 'basic_nginx:1.25.0' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'echo "hello world!"'
            }
        }
    }
}