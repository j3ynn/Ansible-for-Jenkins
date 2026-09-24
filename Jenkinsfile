---

pipeline {
    agent any

    stages {
        stage('pull e push immagini') {
            steps {
                script {
                    def images = [
                        # variabile + ciclo for per iterare nel dizionario ansible
                        "nginx": [
                            source: [ repo: "staging.local:5000", tag: "1.27-rc3" ],
                            targets: [
                                [ repo: "prod.local:5000", tag: "1.27" ],
                                [ repo: "prod.local:5000", tag: "stable" ],
                                [ repo: "dr.local:5000", tag: "1.27" ]
                            ]
                        ]
                        "redis": [
                            source: [ repo: "staging.local:5000", tag: "7.4" ],  
                            targets: [ repo: "prod.local:5000", tag: "7.4" ]
                        ]
                    ]

                }
            }
        }
    }
}

images:
  - nginx:
    source:
      repo: "staging.local:5000"
      tag: "1.27-rc3"
    targets:
      - repo: "prod.local:5000"
        tag: "1.27"
      - repo: "prod.local:5000"
        tag: "stable"
      - repo: "dr.local:5000"
        tag: "1.27"
  - redis:
    source:
      repo: "staging.local:5000"
      tag: "7.4"
    targets:
      - repo: "prod.local:5000"
        tag: "7.4"
