// Jenkinsfile
String credentialsId = 'awsCredentials'

try {
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }

  // Run terraform init
  stage('init') {
    node {
      withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: credentialsId,
        accessKeyVariable: 'AKIA3VGCKVNJ763YAH2A', //expired keys for the purpose of demo only
        secretKeyVariable: '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' //expired keys for the purpose of demo only
      ]]) {
        ansiColor('xterm') {
          sh '/usr/local/bin/terraform init'
        }
      }
    }
  }

  // Run terraform plan
  stage('plan') {
    node {
      withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: credentialsId,
        accessKeyVariable: 'AKIA3VGCKVNJ763YAH2A', //expired keys for the purpose of demo only
        secretKeyVariable: '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' //expired keys for the purpose of demo only
      ]]) {
        ansiColor('xterm') {
          sh '/usr/local/bin/terraform plan'
        }
      }
    }
  }

  if (env.BRANCH_NAME == 'master') {

    // Run terraform apply
    stage('apply') {
      node {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AKIA3VGCKVNJ763YAH2A', //expired keys for the purpose of demo only
          secretKeyVariable: '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' //expired keys for the purpose of demo only
        ]]) {
          ansiColor('xterm') {
            sh '/usr/local/bin/terraform apply -auto-approve'
          }
        }
      }
    }

    // Run terraform show
    stage('show') {
      node {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AKIA3VGCKVNJ763YAH2A', //expired keys for the purpose of demo only
          secretKeyVariable: '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' //expired keys for the purpose of demo only
        ]]) {
          ansiColor('xterm') {
            sh '/usr/local/bin/terraform show'
          }
        }
      }
    }
  }
  currentBuild.result = 'SUCCESS'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
  currentBuild.result = 'ABORTED'
}
catch (err) {
  currentBuild.result = 'FAILURE'
  throw err
}
finally {
  if (currentBuild.result == 'SUCCESS') {
    currentBuild.result = 'SUCCESS'
  }
}