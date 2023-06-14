APPLICATION_FQDN = 'nginx.downstream.billylieberman.com'
NAMESPACE = "basic-nginx"
IMAGE_PROJECT = "basic_nginx"
IMAGE_REPOSITORY = "basic_nginx"
IMAGE_REGISTRY = "harbor.downstream.billylieberman.com"
IMAGE_TAG = "${env.BUILD_ID}"
// docker push harbor.downstream.billylieberman.com/basic_nginx/REPOSITORY[:TAG]
IMAGE_NAME="${IMAGE_REGISTRY}/${IMAGE_PROJECT}/${IMAGE_REPOSITORY}:${env.BUILD_ID}"

//REGISTRY_CREDENTIALS_ID = credentials('harbor-jenkins-username')
//REGISTRY_CREDENTIALS_PW = credentials('harbor-jenkins-pw')
//REGISTRY_CREDENTIALS = credentials('harbor-jenkins')

pipeline {
    agent {
        kubernetes {
            cloud 'kubernetes'
            inheritFrom 'default'
        }
    }

    stages { 
        stage('Initialize') {
            steps{
                container ('jnlp') {
                    script {
                        sh 'curl -LO https://dl.k8s.io/release/v1.25.9/bin/linux/amd64/kubectl'
                        sh 'chmod +x kubectl'
                        // sh 'pwd'
                        // sh 'echo \"export PATH=$PATH:/home/jenkins/agent/workspace/basic_nginx_main\" >> /home/jenkins/.bashrc'
                        // sh 'sleep 600'
                    }
                }
            }
        }
        stage('Build') {
            steps {
                container ('docker') {
                    script {
                        docker_image = docker.build("${IMAGE_NAME}")
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
            environment {
                HARBOR_CREDS = credentials('harbor-jenkins')
                IMAGE_REG = "$IMAGE_REGISTRY"
            }
            steps {
                container ('docker') {
                    script {
                        // checkout scm
                        // sh "docker login -u ${}"
                        // sh 'echo username: $HARBOR_CREDS_USR'
                        sh 'echo $REG_PW | docker login $IMAGE_REG -u $REG_USR --password-stdin'
                        //sh 'docker login $IMAGE_REG -u $HARBOR_CREDS_USR -p $HARBOR_CREDS_PSW'
                        docker.withRegistry("https://${IMAGE_REGISTRY}") {
                            docker_image.push("${IMAGE_TAG}")
                            docker_image.push("latest")
                        }
                        // sh "docker push $IMAGE_NAME"
                    }
                }
            }
            
        }

        stage('Deploy to Development') {
            environment {
                PATH='$PATH:/home/jenkins/agent/workspace/basic_nginx_main'
            }
            steps{
                container('jnlp') {
                    script{
                        withKubeConfig([credentialsId: 'jenkins-deploy', serverUrl: 'https://kubernetes.default']) {
                            sh "kubectl apply -n ${NAMESPACE} -f kubernetes/*.yaml"
                        }
                    }
                }
                // container('docker') {
                    // sh "docker run rancher/kubectl:v1.24.14 apply -n ${NAMESPACE} -f kubernetes/*.yaml"
                // }
                
            }
        }
        // stage('Integration Tests') {}
        // stage('Promote') {}
        // stage('Deploy to Production') {}
    }

}