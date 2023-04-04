node {
    def app

    stage('Clone repository') {
      

        checkout scm
    } 
    /*
    docker {
            image 'jenkins/jenkins:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        } */

    stage('Build image') {
        steps{ 
            script{
                sh 'docker build -t vignanbaligari/jenkinstest .'
            }

        }
       // app = docker.build("vignanbaligari/jenkinstest")
       //sh 'docker build -t vignanbaligari/jenkinstest .'
    }

    stage('Test image') {
  

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
        }
    }
    
    stage('Trigger ManifestUpdate') {
                echo "triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }
}
