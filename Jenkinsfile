IMAGE_REPOSITORY = "basic_nginx"
TARGET_CLUSTER_DOMAIN = "harbor.downstream.billylieberman.com"
pipeline {
    agent {
        kubernetes {
            cloud 'kubernetes'
            inheritFrom 'default'
        }
    }

    podTemplates = new PodTemplates()

    podTemplates.dockerTemplate {
        podTemplates.mavenTemplate {
            node(POD_LABEL) {
            container('docker') {
                sh "echo hello from $POD_CONTAINER" // displays 'hello from docker'
            }
            container('maven') {
                sh "echo hello from $POD_CONTAINER" // displays 'hello from maven'
            }
            }
        }
    }

    // podTemplate(containers: [
        // containerTemplate(name: 'docker', image: 'docker:latest', command: 'sleep', args: '99d')
    // ])
    // def docker_image

    // stage('Initialize') {
        // def dockerHome = tool 'myDocker'
        // env.PATH = "${dockerHome}/bin:${env.PATH}"
    // }

    stages { 
        stage('Checkout') {
            steps { 
                container('jnlp') {
                    script {
                        //checkout scm
                        sh "ls -la"
                    }
                }
            }
        }

        stage('Build') {
            steps {
                container ('docker') {
                    script {
                        // checkout scm
                        //docker_image = docker.build("basic_nginx.${env.BUILD_ID}")
                        sh "ls -la"
                    }
                }
            }
        }

        // stage('Unit Tests') {
            // docker_image.inside {
                // sh 'echo "Tests passed"'
            // }
        // }

        // stage('Push') {
            // docker.withRegistry(TARGET_CLUSTER['REGISTRY_URI'], TARGET_CLUSTER['REGISTRY_CREDENTIALS_ID']) {
                // docker_image.push(IMAGE_TAG)
                // docker_image.push("latest")
            // }
        // }

        // stage('Deploy to Development') {}
        // stage('Integration Tests') {}
        // stage('Promote') {}
        // stage('Deploy to Production') {}
    }

}

// pipeline {
    // agent {
        // docker { image 'docker' }
    // }
    // stages {
        // stage('Test') {
            // steps {
                // sh 'echo "hello world!"'
            // }
        // }
    // }
// }