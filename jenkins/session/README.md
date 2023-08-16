for accessing inbuild vars

http://3.111.157.124:8080/env-vars.html/

 stage('build') {

            when {

                expression {
                    BRANCH_NAME == 'dev'
                }
            }
            steps {
                echo 'Building the project...'
            }
        }


#sh "mvn install"