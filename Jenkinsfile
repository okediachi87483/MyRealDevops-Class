node{
    stage('checkout'){
        build job: "checkout"
    }
    stage('build'){
      build job: "build"  
    }
    stage('code-scanning'){
        build job: "sonar"
    }
    stage('code-coverage'){
        build job: "code-coverage"
    }
    stage('archive-artifacts'){
        build job: "archive_artifact"
    }
    stage('publish-to-artifactory'){
        build job: "publish-to-artifactory"
    }
    stage("Manager Approval"){
        echo "Taking Approval From Manager"
        timeout(time: 7, unit: "DAYS"){
            input message: "Do you want to Deploy?", submitter: "admin"
        }
    }
    stage('deployment'){
        build job: "deployment"
    }
}
