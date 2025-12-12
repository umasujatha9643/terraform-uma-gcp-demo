pipeline {
  agent {
    docker {
      image 'hashicorp/terraform:1.5.7'
    }
  }

  environment {
    GOOGLE_CLOUD_KEY = credentials('gcp-key')
  }

  stages {
    stage('Setup Credentials') {
      steps {
        sh 'echo "$GOOGLE_CLOUD_KEY" > gcp-key.json'
      }
    }

    stage('Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Validate') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Plan') {
      steps {
        sh 'terraform plan'
      }
    }

    stage('Apply') {
      when { expression { params.APPLY } }
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
  }

  parameters {
    booleanParam(name: 'APPLY', defaultValue: false, description: 'Apply Terraform changes')
  }
}
