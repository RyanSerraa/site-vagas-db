pipeline {
    agent any

    environment {
        FLYWAY_IMAGE = "flyway/flyway:10"
    }

    
        stage('Validate') {
            steps {
                sh '''
                docker run --rm \
                  -v /home/ryan-serra/site-vagas-db/migrations:/flyway/sql \
                  flyway/flyway:10 \
                  -url="$DB_URL" \
                  -user="$DB_USER" \
                  -password="$DB_PASS" \
                  -locations=filesystem:/flyway/sql \
                  -ignoreMigrationPatterns='*:pending' \
                  validate
                '''
            }
        }

       stage('Migrate') {
            steps {
                sh '''
                docker run --rm \
                  -v /home/ryan-serra/site-vagas-db/migrations:/flyway/sql \
                  flyway/flyway:10 \
                  -url="$DB_URL" \
                  -user="$DB_USER" \
                  -password="$DB_PASS" \
                  -locations=filesystem:/flyway/sql \
                  migrate
                '''
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