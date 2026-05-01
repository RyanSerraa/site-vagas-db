pipeline {
    agent any

    environment {
        DB_URL  = credentials('DB_URL')
        DB_USER = credentials('DB_USER')
        DB_PASS = credentials('DB_PASS')
    }

    stages {
        stage('Validate') {
            steps {
                sh '''
                docker run --rm \
                  -v "$WORKSPACE/migrations:/flyway/sql" \
                  flyway/flyway:10 \
                  -url="$DB_URL" \
                  -user="$DB_USER" \
                  -password="$DB_PASS" \
                  -locations=filesystem:/flyway/sql \
                  -ignoreMigrationPatterns="*:pending" \
                  validate
                '''
            }
        }

        stage('Migrate') {
            steps {
                sh '''
                docker run --rm \
                  -v "$WORKSPACE/migrations:/flyway/sql" \
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
}