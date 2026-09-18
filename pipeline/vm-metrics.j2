pipeline {
    agent any

    stages {

        stage ('vm raggiungibile'){
            steps {
                script {
                    env.AVAILABILITY = sh (
                        script: '''
                            if curl -s --max-time 5 http://192.168.3.165:9100/metrics > /dev/null
                            then
                                echo "AVAILABLE"
                            else
                                echo "UNAVAILABLE"
                            fi
                        ''',
                        returnStdout: true
                    ).trim()
                    
                    echo "VM: ${env.AVAILABILITY}" 
                }
            }
        }

        stage('metriche') {
            when {
                expression {
                    env.AVAILABILITY == 'AVAILABLE'
                }
            }
            steps {
                script {
                    env.HOSTNAME = sh(
                        script: "curl -s http://192.168.3.165:9100/metrics | grep '^node_uname_info' | grep -oP 'nodename=\"\\K[^\"]+'",
                        returnStdout: true
                    ).trim()
                    
                    env.KERNEL = sh(
                        script: "curl -s http://192.168.3.165:9100/metrics | grep '^node_uname_info' | grep -oP 'release=\"\\K[^\"]+'",
                        returnStdout: true
                    ).trim()

                    env.LOAD_AVERAGE = sh(
                        script: "curl -s http://192.168.3.165:9100/metrics | awk '/^node_load1 / {print \$2}'",
                        returnStdout: true
                    ).trim()

                    env.RAM_AVAILABLE = sh(
                        script: "curl -s http://192.168.3.165:9100/metrics | awk '/^node_memory_MemAvailable_bytes / {print \$2 / 1024 / 1024 / 1024}'",
                        returnStdout: true
                    ).trim()

                    echo "hostname: ${env.HOSTNAME}"
                    echo "kernel: ${env.KERNEL}"
                    echo "load average: ${env.LOAD_AVERAGE}"
                    echo "ram available: ${env.RAM_AVAILABLE} GB"
                }
            }
        }

        stage('body email') {
            steps {
                mail to: 'jenny.bellucci@sourcesense.com',
                    subject: 'metriche',
                    body: """
                    metriche vm ${env.HOSTNAME}

                    kernel: ${env.KERNEL}
                    load average: ${env.LOAD_AVERAGE}
                    ram available: ${env.RAM_AVAILABLE} GB
                    """
            }
        }
    }
}

