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
                  validate
                '''
            }
        }

        stage('Migrate') {
            steps {
                sh '''
                ls -l migrations

                docker run --rm \
                -v $(pwd)/migrations:/flyway/sql \
                flyway/flyway:10 \
                -url=$DB_URL \
                -user=$DB_USER \
                -password=$DB_PASS \
                info
                '''
            }
        }
    }
}
