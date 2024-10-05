pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select action: apply or destroy')
    }
    environment {
        // Define AWS credentials as environment variables
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        REGION                = 'us-east-1'
    }
    stages {
        stage('Checkout') {
             when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                // Check out the repository with Terraform code
                git branch: 'main', 
                    url: 'https://github.com/kshamata7/Redis_Demo_Final.git'
            }
        }
        stage('Terraform Init') {
                         when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir('terraform') {
                    sh '''
                        terraform init \
                        -backend-config="bucket=redis-kshamata-bucket" \
                        -backend-config="key=terraform/state" \
                        -backend-config="region=${REGION}" \
                        -backend-config="dynamodb_table=demo"
                    '''
                }
            }
        }
        stage('Terraform Plan') {
             when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir('terraform') {
                    sh 'terraform plan -lock=false'
                }
            }
        }
        stage('Terraform Apply') {
             when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir('terraform') {
                    sh '''
                        terraform apply -auto-approve -lock=false
                        terraform output -raw IP_Public_Bastion > bastion_ip.txt
                        terraform output -raw IP_redis > redis_ip.txt
                        terraform output -raw IP_redis02 > redis_ip02.txt
                    '''
                }
            }
        }
        stage('Approval for Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                // Prompt for approval before destroying resources
                input "Do you want to Terraform Destroy?"
            }
        }
        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                dir('terraform') {
                    sh 'terraform destroy -auto-approve'
                }
            }
            post {
                always {
                    // Cleanup workspace after the build
                    cleanWs()
                }
            }
        }
        stage('Ansible Playbook Execution') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir('terraform') {
                    // Checking if the output files exist before proceeding
                    script {
                        def bastionIpPath = "${env.WORKSPACE}/terraform/bastion_ip.txt"
                        def redisIpPath = "${env.WORKSPACE}/terraform/redis_ip.txt"
                        def redisIpPath02 = "${env.WORKSPACE}/terraform/redis_ip02.txt"
                        if (fileExists(bastionIpPath) && fileExists(redisIpPath) && fileExists(redisIpPath02)) {
                            def bastionIp = readFile(bastionIpPath).trim()
                            def redisIp = readFile(redisIpPath).trim()
                            def redisIp02 = readFile(redisIpPath02).trim()

                            // Dynamically creating the inventory file with the correct IP addresses
                            writeFile file: 'inventory', text: """
                            [bastion]
                            ${bastionIp} ansible_ssh_private_key_file=/var/lib/jenkins/DevPemKey.pem ansible_user=ubuntu
                            [Redis]
                            ${redisIp} ansible_ssh_private_key_file=/var/lib/jenkins/DevPemKey.pem ansible_user=ubuntu
                            [Redis02]
                            ${redisIp02} ansible_ssh_private_key_file=/var/lib/jenkins/DevPemKey.pem ansible_user=ubuntu
                            """

                            // Disable host key checking during scp and ssh
                            sh """
                                scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/DevPemKey.pem /var/lib/jenkins/DevPemKey.pem ubuntu@${bastionIp}:/home/ubuntu/
                                ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/DevPemKey.pem ubuntu@${bastionIp} 'sudo chmod 400 /home/ubuntu/DevPemKey.pem'
                            """

                            sh '''
                            ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory /var/lib/jenkins/workspace/Redis/playbook.yml
                            '''
                        } else {
                            error "One or both of the IP files (bastion_ip.txt, redis_ip.txt) were not found!"
                        }
                    }
                }
            }
        }
    }
}
