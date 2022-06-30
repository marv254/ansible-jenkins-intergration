pipeline{
    agent any
    stages {
        stage("copy files to ansible server"){
            steps{
                script{
                    echo "Copying all nesessary files to ansible control node"
                    sshagent(['ansible-server-key']){
                        sh "scp -o StrictHostKeyChecking=no ansible/* ec2-user@13.244.186.177:/home/ec2-user"

                        withCredentials([sshUserPrivateKey(credentialsId: "ec2-servers-key", keyFileVariable: 'keyfile', usernameVariable: 'user')]){
                            sh  'sudo scp $keyfile ec2-user@13.244.186.177:/home/ec2-user/ssh-key.pem'
                        }
                    }
                }
            }
        }
    }
}