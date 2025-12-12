pipeline {
  agent {
    docker {
      image 'hashicorp/terraform:light'
      args '--entrypoint="" -u root'
    }
  }

  environment {
    GOOGLE_CLOUD_KEY_FILE = credentials('gcp-key')
  }

  parameters {
    booleanParam(name: 'APPLY', defaultValue: false, description: 'Apply Terraform changes?')
  }

  stages {

    stage('Setup Credentials') {
      steps {
        sh '''
          cp "$GOOGLE_CLOUD_KEY_FILE" gcp-key.json
          export GOOGLE_APPLICATION_CREDENTIALS=gcp-key.json
        '''
      }
    }

    stage('Terraform Init') {
      steps {
        sh '''
          export GOOGLE_APPLICATION_CREDENTIALS=gcp-key.json
          terraform init
        '''
      }
    }

    stage('Terraform Validate') {
      steps {
        sh '''
          export GOOGLE_APPLICATION_CREDENTIALS=gcp-key.json
          terraform validate
        '''
      }
    }

    stage('Terraform Plan') {
      steps {
        sh '''
          export GOOGLE_APPLICATION_CREDENTIALS=gcp-key.json
          terraform plan
        '''
      }
    }

    stage('Terraform Apply') {
      when { expression { params.APPLY == true } }
      steps {
        sh '''
          export GOOGLE_APPLICATION_CREDENTIALS=gcp-key.json
          terraform apply -auto-approve
        '''
      }
    }
  }
}
