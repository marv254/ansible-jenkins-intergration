pipeline{
    agent any
    stages {
        stage("copy files to ansible server"){
            steps{
                script{
                    echo "Copying all nesessary files to ansible control node"
                    sshagent(['ansible-server-key']){
                        sh "scp -o StrictHostKeyChecking=no ansible/* ec2-user@13.244.114.195:/home/ec2-user"

                        withCredentials([sshUserPrivateKey(credentialsId: "ec2-servers-key", keyFileVariable: 'keyfile', usernameVariable: 'user')]){
                            sh  'scp $keyfile ec2-user@13.244.114.195:/home/ec2-user/ssh-key.pem'
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
                remote.host = '13.244.114.195'
                remote.allowAnyHosts = true

                withCredentials([sshUserPrivateKey(credentialsId: "ansible-server-key", keyFileVariable: 'keyfile', passphraseVariable: '', usernameVariable: 'user')]){
                    remote.user = user
                    remote.identityFile = keyfile
                    sshCommand remote: remote, command: "bash prepare-server.sh"
                    sshCommand remote: remote, command: "ansible-playbook docker-and-compose.yaml"
            }
          }  
        }
    }
}
}