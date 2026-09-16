pipeline {
    agent any

    stages {

        stage ('extract metrics') {
            steps {
                sh '''
                    sh 'ssh j3ynn@192.168.3.165 "top -bn1 | grep Cpu"'

                '''
            }
        }
    }
}