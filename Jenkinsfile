pipeline {
    agent any

    environment {
        KUBECONFIG = credentials('kubeconfig-cluster-rabbitmq')
    }

    parameters {

        string(name: 'NAMESPACE', defaultValue: 'cluster-rabbitmq', description: 'namespace dedicato rabbitmq')
        string(name: 'CLUSTERNAME', defaultValue: 'trove-rabbitmq-test', description: 'nome del cluster rabbitmq')

        string(name: 'VHOST_ROMA', defaultValue: 'trove-roma', description: 'nome vhost roma')
        string(name: 'USER_ROMA', defaultValue: 'trove-roma', description: 'nome user roma')
        string(name: 'CREDENTIAL_ID_ROMA', defaultValue: 'trove-roma', description: 'credential id roma')
        string(name: 'VHOST_MILANO', defaultValue: 'trove-milano', description: 'nome vhost milano')
        string(name: 'USER_MILANO', defaultValue: 'trove-milano', description: 'nome user milano')
        string(name: 'CREDENTIAL_ID_MILANO', defaultValue: 'trove-milano', description: 'credential id milano')

        choice(name: 'OPTION', choices: ['tutti', 'roma', 'milano'], description: 'scelta per creazione vhost e user')
    }

    stages {

        stage('download kubectl') {
            steps {
                sh '''
                    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                    chmod +x kubectl
                '''
            }
        }

        stage('deploy cluster rabbitmq') {
            steps {
                sh """
                    ./kubectl create namespace ${params.NAMESPACE} || true
                    ./kubectl apply -f rabbitmq-trove-cluster-local.yaml
                """
            }
        }

        stage('aspetta pod') {
            steps {
                sh """
                    ./kubectl wait \\
                    --for=condition=AllReplicasReady=True \\
                    rabbitmqcluster/${params.CLUSTERNAME} \\
                    -n ${params.NAMESPACE} \\
                    --timeout=300s
                """
            }
        }

        stage('create vhost roma') {
            when {
                expression {
                    params.OPTION == 'roma' || params.OPTION == 'tutti'
                }
            }
            steps {
                sh """
                    ./kubectl exec -n ${params.NAMESPACE} trove-rabbitmq-test-server-0 -- \\
                    rabbitmqctl add_vhost ${params.VHOST_ROMA} || true
                """
            }
        }
        stage('create vhost milano') {
            when {
                expression {
                    params.OPTION == 'milano' || params.OPTION == 'tutti'
                }
            }
            steps {
                sh """
                    ./kubectl exec -n ${params.NAMESPACE} trove-rabbitmq-test-server-0 -- \\
                    rabbitmqctl add_vhost ${params.VHOST_MILANO} || true
                """
            }
        }

        stage('create users roma') {
            when {
                expression {
                    params.OPTION == 'roma' || params.OPTION == 'tutti'
                }
            }
            steps {
                withCredentials([
                    string(
                        credentialsId: params.CREDENTIAL_ID_ROMA,
                        variable: 'trove_roma'
                    )
                ]) {
                    sh """
                        ./kubectl exec -n ${params.NAMESPACE} trove-rabbitmq-test-server-0 -- \\
                        rabbitmqctl add_user ${params.USER_ROMA} "$$trove_roma" || true

                        ./kubectl exec -n ${params.NAMESPACE} trove-rabbitmq-test-server-0 -- \\
                        rabbitmqctl set_permissions -p ${params.VHOST_ROMA} ${params.USER_ROMA} ".*" ".*" ".*"
                    """
                }
            }
        }
        stage('create users milano') {
            when {
                expression {
                    params.OPTION == 'milano' || params.OPTION == 'tutti'
                }
            }
            steps {
                withCredentials([
                    string(
                        credentialsId: params.CREDENTIAL_ID_MILANO,
                        variable: 'trove_milano'
                    )
                ]) {
                    sh """
                        ./kubectl exec -n ${params.NAMESPACE} trove-rabbitmq-test-server-0 -- \\
                        rabbitmqctl add_user ${params.USER_MILANO} "$$trove_milano" || true

                        ./kubectl exec -n ${params.NAMESPACE} trove-rabbitmq-test-server-0 -- \\
                        rabbitmqctl set_permissions -p ${params.VHOST_MILANO} ${params.USER_MILANO} ".*" ".*" ".*"
                    """
                }
            }
        }




    }
}
