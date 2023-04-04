pipeline{
    agent any
    tools{
            docker:'docker_20_10_17'
        }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        def image = docker.build('vignanbaligari/jenkinstest')
                    }
                }
            }
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
}