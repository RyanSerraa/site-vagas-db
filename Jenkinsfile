pipeline {
    agent any

    environment {
        DB_URL  = credentials('DB_URL')   // com sslmode=require
        DB_USER = credentials('DB_USER')
        DB_PASS = credentials('DB_PASS')
    }

    stages {
        stage('Debug migrations') {
            steps {
                sh '''
                  echo "Workspace: $WORKSPACE"
                  docker run --rm \
                    -v $WORKSPACE/migrations:/flyway/sql \
                    busybox \
                    ls -l /flyway/sql
                '''
            }
        }

        stage('Validate') {
            steps {
                sh '''
                docker run --rm \
                  -v $WORKSPACE/migrations:/flyway/sql \
                  flyway/flyway:10 \
                  -url="$DB_URL" \
                  -user="$DB_USER" \
                  -password="$DB_PASS" \
                  -locations=filesystem:/flyway/sql \
                  validate
                '''
            }
        }

        stage('Migrate') {
            steps {
                sh '''
                docker run --rm \
                  -v $WORKSPACE/migrations:/flyway/sql \
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