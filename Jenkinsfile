pipeline {
    agent any

    environment {
        FLYWAY_IMAGE = "flyway/flyway:10"
    }

    stages {
        stage('Validate') {
            steps {
                withCredentials([
                    string(credentialsId: 'DB_URL', variable: 'DB_URL'),
                    string(credentialsId: 'DB_USER', variable: 'DB_USER'),
                    string(credentialsId: 'DB_PASS', variable: 'DB_PASS')
                ]) {
                    sh '''
                    docker run --rm \
                      -v "${WORKSPACE}/migrations:/flyway/sql" \
                      $FLYWAY_IMAGE \
                      -url="$DB_URL" \
                      -user="$DB_USER" \
                      -password="$DB_PASS" \
                      validate
                    '''
                }
            }
        }

        stage('Migrate') {
            steps {
                withCredentials([
                    string(credentialsId: 'DB_URL', variable: 'DB_URL'),
                    string(credentialsId: 'DB_USER', variable: 'DB_USER'),
                    string(credentialsId: 'DB_PASS', variable: 'DB_PASS')
                ]) {
                    sh '''
                    docker run --rm \
                      -v "${WORKSPACE}/migrations:/flyway/sql" \
                      $FLYWAY_IMAGE \
                      -url="$DB_URL" \
                      -user="$DB_USER" \
                      -password="$DB_PASS" \
                      migrate
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Migração executada com sucesso'
        }
        failure {
            echo 'Falha na execução do Flyway'
        }
    }
}