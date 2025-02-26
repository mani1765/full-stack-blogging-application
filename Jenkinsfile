pipeline {
    agent any
    
    tools {
        maven 'maven3'
        jdk 'jdk17'
    }
    
    environment{
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Git Check Out') {
            steps {
                git branch: 'main', url: 'https://github.com/mani1765/full-stack-blogging-application.git'
            }
        }
        
        stage('Maven Compile') {
            steps {
                sh "mvn compile"
            }
        }
        
        stage('Maven Test') {
            steps {
                sh "mvn test"
            }
        }
        
        stage('Trivy FS Scan') {
            steps {
                sh "trivy fs --format table -o fs.html ."
            }
        }
        
        stage('SonarQube Scanner') {
            steps {
                withSonarQubeEnv('sonar-server'){
                    sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Blogging-app -Dsonar.projectKey=Blogging-app \
                       -Dsonar.java.binaries=target '''
                }
            }
        }
        
        stage('Maven Build') {
            steps {
                sh "mvn package"
            }
        }
        
        stage('Maven deploy') {
            steps {
               withMaven(globalMavenSettingsConfig: 'settings.xml', jdk: 'jdk17', maven: 'maven3', mavenSettingsConfig: '', traceability: true) {
               sh "mvn deploy"
             }
            }
        }
        
       stage('Docker Build') {
        steps {
          script {
            withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                // Docker build command goes here
                sh "docker build -t mani1765/blogging-app:latest ."
            }
        }
    }
}

        stage {

steps {

withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'demo-cluster', contextName: '', credentialsId: 'k8-cred', namespace: 'webapps', serverUrl: 'http://aws-api-endpoint.com/']]) {
    
sh "kubectl apply -f deployment-service.yml"
sleep 30

      }
   }
}

        stage('Trivy Image Scan') {
            steps {
                sh "trivy image --format table -o image.html mani1765/blogging-app:latest"
            }
        }
        
        stage('Docker Push') {
         steps {
          script {
            withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                // Docker push command goes here
                sh "docker push mani1765/blogging-app:latest"
            }
        }
    }
}

    }
}
