pipeline {
    agent any
    triggers {
        pollSCM('*/1 * * * *')
    }
    stages {
         stage('build-docker-image') {
            steps {
               buildApp()
            }
        }
         stage('deploy-to-dev') {
            steps {
                deploy("DEV")
            }
        }
         stage('tests-on-dev') {
            steps {
                test("DEV")
            }
        }
        stage('deploy-to-stg') {
            steps {
                deploy("STG")
            }
        }
         stage('tests-on-stg') {
            steps {
                test("STG")
            }
        }
        stage('deploy-to-prd') {
            steps {
                deploy("PROD")
            }
        }
         stage('tests-on-prod') {
            steps {
                test("PROD")
            }
        }
    }
}

def buildApp(){
    echo "Building of Python miscroservice is starting.."
    sh "docker build -t emilsriekstins/python-greetings-app:latest ."

    echo "Pushing image to docker registry.."
    sh "docker push emilsriekstins/python-greetings-app:latest"
}

def deploy(String environment) {
    echo "Deploying Python microservice ${environment} environment.."
    sh "docker pull emilsriekstins/python-greetings-app:latest" 
    String lowerCaseEnv = environment.toLowerCase()
    sh "docker compose stop greetings-app-${lowerCaseEnv}"
    sh "docker compose rm greetings-app-${lowerCaseEnv}"
    sh "docker compose up -d greetings-app-${lowerCaseEnv}"
}

def test(String environment){
    echo "API test executuon against Python microservice on ${environment} environment.."
    sh "docker pull emilsriekstins/api-tests:latest"
    def directory = pwd()
    sh "echo '${directory}'"
    sh "docker run --rm --network=host emilsriekstins/api-tests:latest run greetings greetings_${environment}"
}
