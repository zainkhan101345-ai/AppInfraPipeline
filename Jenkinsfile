pipeline {
    agent any
    parameters {
        booleanParam(name: 'Plan_Terraform', defaultValue: false, description: 'Terraform Plan')
        booleanParam(name: 'Apply_Terraform', defaultValue: false, description: 'Terraform Apply')
        booleanParam(name: 'Destroy_Terraform', defaultValue: false, description: 'Terraform Destroy')
    }

    stages {
         stage('Clone Repo') {
            steps {

                echo '================ Clone Repo ================'

                dir('AWSInfra') {
                    bat 'dir'
                }

                echo '================================================='
            }
        }

        stage('Terraform Init') {
            steps {

                echo '================ Terraform Init ================'

                dir('AWSInfra') {
                    bat 'dir'
                    bat 'terraform init'
                }

                echo '================================================='
            }
        }
        stage('Terraform Plan'){
                steps {
               script{
                  if (params.Plan_Terraform){
                    echo '================ Terraform Plan ================'

                         dir('AWSInfra') {
                             bat 'terraform plan'
                         }

                         echo '================================================='
                    
                  }

               }
                
            }
        }
        stage('Terraform Apply'){
                steps {
               script{
                  if (params.Apply_Terraform){
                    echo '================ Terraform Apply ================'

                         dir('AWSInfra') {
                             bat 'terraform apply -auto-approve'
                         }
 
                         echo '================================================='
                    
                  }

               }
                
            }
        }
        stage('Terraform Destroy'){
                steps {
               script{
                  if (params.Destroy_Terraform){
                    echo '================ Terraform Destroy ================'

                         dir('AWSInfra') {
                             bat 'terraform destroy -auto-approve'
                         }

                         echo '================================================='
                    
                  }

               }
                
            }
        }
    }
}