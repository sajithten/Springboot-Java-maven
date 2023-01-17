pipeline{
    agent any
    tools{
        maven 'maven'
    }
    stages{
        stage('Git checkout'){
            steps{
                git branch:'master',url:'https://github.com/sajithten/springboot-java-maven.git'
              }
            }
        stage ('Build the project'){
            steps{
                sh 'mvn clean package'
                }
            }
        stage ('Building docker image'){
            steps{
                sh 'docker image build -t sajithten/springboot:$BUILD_NUMBER .'

                 }
            }
        stage ('Login into docker & push image'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'password', usernameVariable: 'username')]) {
                 sh 'docker login -u ${username} -p ${password}'
                }
                 sh 'docker image push sajithten/springboot:$BUILD_NUMBER'
            }
        }
        stage ('Stop and removong previous container'){
            steps{
                sh 'docker ps -f name=myjavacontainer -q | xargs --no-run-if-empty docker container stop'
                sh 'docker container ls -a -f name=myjavacontainer -q | xargs -r docker container rm'
            }
        }
        stage('Run docker container'){
            steps{
                sh 'docker run --name=myjavacontainer -p 2255:8080 -d sajithten/springboot:$BUILD_NUMBER'
            }
        }

      }      
}            
 
