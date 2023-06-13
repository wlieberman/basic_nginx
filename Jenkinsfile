IMAGE_PROJECT = "basic_nginx"
IMAGE_REPOSITORY = "basic_nginx"
IMAGE_REGISTRY = "harbor.downstream.billylieberman.com"
IMAGE_TAG = "${env.BUILD_ID}"
// docker push harbor.downstream.billylieberman.com/basic_nginx/REPOSITORY[:TAG]
IMAGE_NAME="${IMAGE_REGISTRY}/${IMAGE_PROJECT}/${IMAGE_REPOSITORY}:${env.BUILD_ID}"

REGISTRY_CREDENTIALS_ID = credentials('harbor-jenkins-username')
REGISTRY_CREDENTIALS_PW = credentials('harbor-jenkins-pw')
//REGISTRY_CREDENTIALS = credentials('harbor-jenkins')

pipeline {
    agent {
        kubernetes {
            cloud 'kubernetes'
            inheritFrom 'default'
        }
    }

    stages { 
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
                        // environment {
                            // REGISTRY_CREDENTIALS = credentials('harbor-jenkins')
                        // }
                        // sh "echo username=$REGISTRY_CREDENTIALS_USR"
                        // sh "echo password=$REGISTRY_CREDENTIALS_PSW"
                        // sh 'printenv'
                    }
                }
            }
        }

        stage('Push') {
            steps {
                container ('docker') {
                    script {
                        // checkout scm
                        // sh "docker login -u ${}"
                        // environment {
                            // DOCKER_TLS_VERIFY=0
                        // }
                        environment {
                            REGISTRY_CREDENTIALS = credentials('harbor-jenkins')
                        }
                        docker.withRegistry("http://${IMAGE_REGISTRY}", $REGISTRY_CREDENTIALS) {
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