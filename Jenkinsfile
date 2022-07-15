pipeline{
    agent any
    environment{
        ansible_server = "ubuntu@13.245.249.167"
    }
    stages {
        stage("copy files to ansible server"){
            steps{
                script{
                    echo "Copying all nesessary files to ansible control node"
                    sshagent(['ansible-server-key']){
                        sh "scp -o StrictHostKeyChecking=no ansible/* $ansible_server:/home/ubuntu"

                        withCredentials([sshUserPrivateKey(credentialsId: "ec2-servers-key", keyFileVariable: 'keyfile', usernameVariable: 'user')]){
                            sh  'scp $keyfile $ansible_server:/home/ubuntu/ssh-key.pem'
                        }
                    }
                }
            }
        }

        stage("execute ansible playbook"){
          steps{
            script{
                echo "Calling ansible playbook to configure ec2 instances"
                def remote = [:]
                remote.name = 'ansible-server'
                remote.host = '13.245.249.167'
                remote.allowAnyHosts = true

                withCredentials([sshUserPrivateKey(credentialsId: "ansible-server-key", keyFileVariable: 'keyfile', usernameVariable: 'user')]){
                    remote.user = user
                    remote.identityFile = keyfile
                    sshCommand remote: remote, command: "ansible-playbook docker-and-compose.yaml"
            }
          }  
        }
    }
        // stage("execute playbook"){
        //     environment {
        //         play = "ansible-playbook docker-and-compose.yaml"
        //     }
        //     steps{
        //         script{
        //             sshagent(['ansible-server-key']){
        //                 sh "ssh -o StrictHostKeyChecking=no ${ansible_server} $play"
                   
        //         }}
        //     }
        // }
}
}