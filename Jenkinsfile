node {
    stage('CheckTerraform'){
        sh 'cd /var/jenkins_home/workspace/pruebavg'
            if ( !fileExists ('terraform_0.12.18_linux_amd64.zip') ){
                echo "Check Terraform"
                sh "apt-get install unzip"
                sh "wget https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip"
                sh "unzip terraform_0.12.18_linux_amd64.zip"
                sh "cp terraform /usr/local/bin/"
            }
            if ( !fileExists ('azure-cli') ){
                echo "Check Azure"
                sh "apt-get update"
                sh "apt-get --yes --force-yes upgrade"
                sh "apt-get upgrade"
                sh "curl -sL https://aka.ms/InstallAzureCliDeb | bash "
            }
        sh 'az version'    
        sh "cp terraform /usr/local/bin/"
        sh 'terraform --version'
    }
    
    stage('login'){
        if ( !fileExists ('main.tf') ){
            checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'vgprueba2', url: 'https://gitlab.digitalcoedevops.com/labs/oe/jenkins-testvg2.git']]])
        }
    }
    
    stage('Variables'){
        sh 'export ARM_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID'
        sh 'export ARM_CLIENT_ID=$AZURE_CLIENT_ID'
        sh 'export ARM_CLIENT_SECRET=$AZURE_CLIENT_SECRET'
        sh 'export ARM_TENANT_ID=$AZURE_TENANT_ID'    
        sh "terraform plan"
    }
    
    stage('Terraform init'){
        echo '\n\nInitializing... \nLooking for *.tf files'
        sh 'terraform init'
    }
    stage('Terraform plan'){
        withEnv(['ARM_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID';'ARM_CLIENT_ID=$AZURE_CLIENT_ID';'ARM_CLIENT_SECRET=$AZURE_CLIENT_SECRET';'ARM_TENANT_ID=$AZURE_TENANT_ID']){   
        sh "terraform plan"
        }
    }
    
    stage('Terraform validate'){
        sh "terraform validate"
    }
    
    stage('Terraform apply'){
       
        sh "terraform apply -auto-approve"
    }
    
    stage('Terraform destroy'){
        sh "terraform destroy -auto-approve"
    }
}
