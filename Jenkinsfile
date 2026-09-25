pipeline {
    agent any

    environment {
        MAX_RESTART = '3'
    }


    stages {






        stage('recovery node_exporter') {
            steps {
                sh '''
                    tentativi=0

                    check() {
                        curl -s --max-time 5 http://192.168.3.165:9100/metrics > /dev/null
                    }

                    restart() {
                        curl -s -X POST http://192.168.3.165:5000/restart
                    }

                    until check
                    do
                        tentativi=$((tentativi + 1))

                        if [ "$tentativi" -gt "$MAX_RESTART" ]; then
                            echo "Superato il numero massimo di restart per node_exporter"
                            exit 1
                        fi

                        echo "node_exporter non attivo - restart $tentativi"
                        restart
                        sleep 5
                    done

                    echo "node_exporter attivo"
                '''
            }
        }

        stage('metriche node_exporter') {
            steps {
                script {
                    env.HOSTNAME = sh(
                        script: 'curl -s http://192.168.3.165:9100/metrics | grep "^node_uname_info" | grep -oP \'nodename="\\K[^"]+\'',
                        returnStdout: true
                    ).trim()
                    env.KERNEL = sh(
                        script: 'curl -s http://192.168.3.165:9100/metrics | grep "^node_uname_info" | grep -oP \'nodename="\\K[^"]+\'',
                        returnStdout: true
                    ).trim()
                    env.LOAD_AVERAGE = sh(
                        script: 'curl -s http://192.168.3.165:9100/metrics | awk '/^node_load1 / {print \$2}'',
                        returnStdout: true
                    ).trim()
                    env.AVAILABLE_RAM = sh(
                        script: 'curl -s http://192.168.3.165:9100/metrics | awk '/^node_memory_MemAvailable_bytes / {print \$2 / 1024 / 1024 / 1024}'',
                        returnStdout: true
                    ).trim()

                    echo "hostname: ${env.HOSTNAME}"
                    echo "kernel: ${env.KERNEL}"
                    echo "load_average: ${env.LOAD_AVERAGE}"
                    echo "available_ram: ${env.AVAILABLE_RAM}"
                }
            }
        }

        stage('email') {
            steps {
                mail to: 'jenny.bellucci@sourcesense.com',
                    subject: 'metriche',
                    body: """
                    hostname: ${env.HOSTNAME}
                    kernel: ${env.KERNEL}
                    load_average: ${env.LOAD_AVERAGE}
                    available_ram: ${env.AVAILABLE_RAM}
                    """
            }
        }

    }
}
