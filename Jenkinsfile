pipeline {
    agent any
    
    environment {
        PATH="/usr/local/bin:/usr/local/sbin:/home/jenkins/.local/bin:$PATH"
        DockerHub_regestry = 'tiptogo/exam-app'
        DockerHub_Credential_id = 'dockerhub'
        myImage = ''
    }

    stages {
        stage('Tests') {
            steps {
                echo 'Testing..'
                sh 'pip install --user -e .[test]'
                sh 'coverage run -m pytest'
                sh 'coverage report'
            }
        }
        stage('Build image') {
            steps {
                echo 'Building..'
                script {
                    myImage = docker.build("${DockerHub_regestry}")
                }
            }
        }

        stage('Push image') {
            steps {
                echo 'Pushing....'
                script {
                    docker.withRegistry( '', DockerHub_Credential_id ) {
                       myImage.push("web_app_1.${BUILD_NUMBER}")
                       myImage.push("latest")
                    }
                }
            }
        }

        stage('Remove unused docker images') {
            steps{
                echo 'Removing unused docker images....'
                sh "docker rmi ${DockerHub_regestry}:web_app_1.${BUILD_NUMBER}"
                sh "docker rmi ${DockerHub_regestry}:latest"
            }
        } 
    }
}
