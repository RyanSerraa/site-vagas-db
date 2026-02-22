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
}