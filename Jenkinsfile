pipeline {
  agent any

  triggers {
    githubPush()
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Restore') {
      steps {
        bat 'dotnet restore frontend\\EasyDevOps\\EasyDevOps.csproj'
      }
    }

stage('Security Scan (Snyk)') {
  steps {
    withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
      bat 'C:\\Tools\\snyk\\snyk.exe --version'
      bat 'cd frontend\\EasyDevOps && dotnet restore EasyDevOps.csproj'
      bat 'cd frontend\\EasyDevOps && if not exist obj\\project.assets.json (echo project.assets.json missing & exit /b 1)'
      bat 'cd frontend\\EasyDevOps && C:\\Tools\\snyk\\snyk.exe test --file=obj\\project.assets.json --severity-threshold=high'
    }
  }
}

    stage('Build') {
      steps {
        bat 'dotnet build frontend\\EasyDevOps\\EasyDevOps.csproj -c Release --no-restore'
      }
    }

    stage('Publish') {
      steps {
        bat 'dotnet publish frontend\\EasyDevOps\\EasyDevOps.csproj -c Release -o out --no-build'
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'out/**', fingerprint: true
    }
  }
}
