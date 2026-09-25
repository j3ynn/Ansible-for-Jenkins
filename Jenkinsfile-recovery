pipeline {
    agent any

    environment {
        MAX_RESTART = '6'
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



    }
}
