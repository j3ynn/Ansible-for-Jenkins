pipeline {
    agent any

    stages {

        stage ('extract metrics') {
            steps {
                'sh curl http://192.168.3.165:9100/metrics'
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

        stage('metriche') {
            steps {
                sh '''
                    hostname=$(curl -s http://192.168.3.165:9100/metrics | grep '^node_uname_info' | grep -oP 'nodename="\\K[^"]+')
                    kernel=$(curl -s http://192.168.3.165:9100/metrics | grep '^node_uname_info' | grep -oP 'release="\\K[^"]+')
                    load_average=$(curl -s http://192.168.3.165:9100/metrics | awk '/^node_load1 / {print $2}')
                    ram_available=$(curl -s http://192.168.3.165:9100/metrics | awk '/^node_memory_MemAvailable_bytes / {print $2 / 1024 / 1024 / 1024}')

                    echo "hostname: $hostname"
                    echo "kernel: $kernel"
                    echo "load average: $load_average"
                    echo "ram available: $ram_available GB"
                '''
            }
        }

        stage('body email') {
            steps {
                sh '''

                '''

            }
        }
    }
}

