pipeline {
    agent any

    stages {

        stage ('extract metrics') {
            steps {
                sh '''
                    curl http://192.168.3.165:9100/metrics
                    //ssh j3ynn@192.168.3.165 "top -bn1 | grep cpu | awk 'END {print 100-$NF"%"}'"
                    //ssh j3ynn@192.168.3.165 "free -m | awk 'NR==2 {print $3}'"
                    //ssh j3ynn@192.168.3.165 "free -m | awk 'NR==2 {print $3}"
                    //ssh j3ynn@192.168.3.165 "df --output=pcent / | tail -n 1 | tr -d ' %'" 
                '''
            }
        }
    }
}