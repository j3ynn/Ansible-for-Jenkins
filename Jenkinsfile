pipeline {
    agent any

    stages {

        stage ('extract metrics') {
            steps {
                sh '''
                    curl http://192.168.3.165:9100/metrics
                '''
            }
        }
    }
}