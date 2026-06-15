pipeline {
    agent any
    environment {
        dotnet = "C:\\Program Files (x86)\\dotnet"
    }
    stages {
        stage("Checkout Repository") {
            steps {
                git url: "https://github.com/Aliyev1999/CICD_PublishSource.git", branch: 'master'
            }
        }
    }
}
