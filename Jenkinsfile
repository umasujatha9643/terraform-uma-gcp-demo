pipeline {
  agent {
    docker {
      image 'hashicorp/terraform:light'
      args '--entrypoint="" -u root'
    }
  }

  environment {
    GOOGLE_CLOUD_KEY = credentials('gcp-key')
  }

  parameters {
    booleanParam(name: 'APPLY', defaultValue: false, description: 'Apply Terraform changes?')
  }

  stages {

    stage('Setup Credentials') {
      steps {
        sh '''
          echo "$GOOGLE_CLOUD_KEY" > gcp-key.json
        '''
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Validate') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan'
      }
    }

    stage('Terraform Apply') {
      when {
        expression { params.APPLY == true }
      }
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
  }
}
