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

        stage ('vm raggiungibile') {
            steps {
                sh '''
                    if curl -s --max-time 5 http://192.168.3.165:9100/metrics > /dev/null
                    then
                    availability="AVAILABLE"
                    else
                    availability="UNAVAILABLE"
                    fi
                    echo "VM: $availability"
                '''
            }
        }
    }
}