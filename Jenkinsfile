IMAGE_PROJECT = "basic_nginx"
IMAGE_REPOSITORY = "basic_nginx"
IMAGE_REGISTRY = "harbor.downstream.billylieberman.com"
IMAGE_TAG = "${env.BUILD_ID}"
// docker push harbor.downstream.billylieberman.com/basic_nginx/REPOSITORY[:TAG]
IMAGE_NAME="${IMAGE_REGISTRY}/${IMAGE_PROJECT}/${IMAGE_REPOSITORY}:${env.BUILD_ID}"

REGISTRY_CREDENTIALS_ID = credentials('harbor-jenkins-username')
REGISTRY_CREDENTIALS_PW = credentials('harbor-jenkins-pw')

pipeline {
    agent {
        kubernetes {
            cloud 'kubernetes'
            inheritFrom 'default'
        }
    }

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
                        docker_image = docker.build("${IMAGE_NAME}")
                        // sh "ls -la"
                    }
                }
            }
        }

        stage('Unit Tests') {
            steps {
                container ('docker') {
                    script {
                        // checkout scm
                        sh "echo \"Tests Passed!\""
                    }
                }
            }
        }

        stage('Push') {
            steps {
                container ('docker') {
                    script {
                        // checkout scm
                        environment {
                            DOCKER_TLS_VERIFY=0
                        }
                        docker.withRegistry("http://${IMAGE_REGISTRY}", 'harbor-jenkins') {
                            docker_image.push(${IMAGE_TAG})
                            docker_image.push("latest")
                        }
                    }
                }
            }
            
        }

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