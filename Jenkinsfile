pipeline {
  agent { label 'jenkins-linux' }
  environment { 
    AWS_EC2_JENKINS_PRIVATE_KEY=credentials('AWS_EC2_JENKINS_PRIVATE_KEY') 
    SLACK_BOT_TOKEN=credentials('HELLO_BOT_SLACK_BOT_TOKEN')
    SLACK_APP_TOKEN=credentials('HELLO_BOT_SLACK_APP_TOKEN')
    JENKINS_WORKSPACE_PATH="${WORKSPACE}"
  }
  stages {
    stage('Deploy Python App') {
      steps {
        sh 'ansible-playbook -i inventory playbook.yml --private-key=$AWS_EC2_JENKINS_PRIVATE_KEY --extra-vars="jenkins_workspace_path=$JENKINS_WORKSPACE_PATH slack_bot_token_value=$SLACK_BOT_TOKEN slack_app_token_value=$SLACK_APP_TOKEN"'
      }
    }
  }
}
