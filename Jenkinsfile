pipeline {
    agent any

    environment {
        // Uses the secret file credential we created
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-tf-key')
        TF_IN_AUTOMATION = "true"
        GOOGLE_PROJECT = "gce-day1-uma"        // change to your project id
        GOOGLE_REGION  = "us-central1"
        GOOGLE_ZONE    = "us-central1-a"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh """
                  echo "Project: $GOOGLE_PROJECT"
                  terraform init
                """
            }
        }

        stage('Terraform Validate') {
            steps {
                sh """
                  terraform fmt -recursive
                  terraform validate
                """
            }
        }

        stage('Terraform Plan') {
            steps {
                sh """
                  terraform plan \
                    -var="project_id=$GOOGLE_PROJECT" \
                    -var="region=$GOOGLE_REGION" \
                    -var="zone=$GOOGLE_ZONE" \
                    -out=tfplan
                """
                archiveArtifacts artifacts: 'tfplan', fingerprint: true
            }
        }

        stage('Approve Apply') {
            steps {
                script {
                    input message: "Apply Terraform changes?", ok: "Apply"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh "terraform apply -auto-approve tfplan"
            }
        }
    }

    post {
        always {
            sh 'terraform show || true'
        }
        success {
            echo "Terraform apply completed successfully ✅"
        }
        failure {
            echo "Terraform pipeline failed ❌"
        }
    }
}
