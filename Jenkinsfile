pipeline{
    agent any
    tools{
        nodejs 'node 23'
    }
     stages{
        stage('Git checkout'){
            steps{
                git branch: 'main', credentialsId: 'Git-token', url: 'https://github.com/Nithin-g1t/LearningTech.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm ci'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
        stage(' Docker image Build'){
            steps{
                sh 'docker build -t c505304/learning:v1'
                sh 'docker build -t c505304/learning:latest'
                sh 'docker tag c505304/learning:v1 c505304/learning:${BUILD_NUMBER}'
                sh 'echo "docker image creation completed"'
            }
        }
        stage(' Docker image push'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'docker_hub_creds', 
                                         passwordVariable: 'DOCKER_PASSWORD', 
                                         usernameVariable: 'DOCKER_USERNAME')]) {
            sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin"

            sh "docker push c505304/learning:${env.BUILD_NUMBER}"   
            }
            }
        }
        
              
        
        
        
        
        
        
