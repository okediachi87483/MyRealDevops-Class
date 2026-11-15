pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                build job: 'checkout'
            }
        }

        stage('build') {
            steps {
                build job: 'build'
            }
        }

        stage('code-scanning') {
            steps {
                build job: 'sonar'
            }
        }

        stage('code-coverage') {
            steps {
                build job: 'code-coverage'
            }
        }

        stage('archive-artifacts') {
            steps {
                build job: 'archive_artifact'
            }
        }

        stage('publish-to-artifactory') {
            steps {
                build job: 'publish-to-artifactory'
            }
        }

        stage('Manager Approval') {
            steps {
                echo 'Taking Approval From Manager'

                timeout(time: 7, unit: 'DAYS') {
                    input message: 'Do you want to Deploy?',
                          submitter: 'admin'
                }
            }
        }

        stage('deployment') {
            steps {
                build job: 'deployment'
            }
        }
    }
}
