node('docker'){
    stage "Container Prep"
        echo("the node is up")
        def mycontainer = docker.image('sgioldasis/ci-docker-in-docker:latest')
        mycontainer.pull() // make sure we have the latest available from Docker Hub
        mycontainer.inside("-u jenkins -v /var/run/docker.sock:/var/run/docker.sock:rw") {
            git 'https://github.com/elastest/elastest-data-manager.git'
            
            // stage "Test"
            //     sh 'ls -la'
            //     echo ("Starting maven tests")
            //     echo ("No tests yet, but these would be integration at least")
            //     sh 'which docker'
                
            stage "Build Alluxio image - Package"
                echo ("building..")
                sh 'chmod +x alluxio/entrypoint.sh'
                //need to be corrected to the organization because at the moment elastestci can't create new repositories in the organization
                def alluxio_image = docker.build("elastest/edm-alluxio","./alluxio")

            stage "Build Hadoop image - Package"
                echo ("building..")
                //need to be corrected to the organization because at the moment elastestci can't create new repositories in the organization
                def hadoop_image = docker.build("elastest/edm-hadoop","./hadoop")

            stage "Build Elasticsearch image - Package"
                echo ("building..")
                //need to be corrected to the organization because at the moment elastestci can't create new repositories in the organization
                def elasticsearch_image = docker.build("elastest/edm-elasticsearch","./elasticsearch")

            stage "Build Kibana image - Package"
                echo ("building..")
                //need to be corrected to the organization because at the moment elastestci can't create new repositories in the organization
                def kibana_image = docker.build("elastest/edm-kibana","./kibana")

            stage "Build Cerebro image - Package"
                echo ("building..")
                //need to be corrected to the organization because at the moment elastestci can't create new repositories in the organization
                def cerebro_image = docker.build("elastest/edm-cerebro","./cerebro")

            stage "Build MySQL image - Package"
                echo ("building..")
                //need to be corrected to the organization because at the moment elastestci can't create new repositories in the organization
                def mysql_image = docker.build("elastest/edm-mysql","./mysql")

            stage "Run docker-compose"
            //    myimage.run()
            //    sh 'chmod +x bin/startup-linux.sh && bin/startup-linux.sh'
                sh 'pwd'
                sh 'docker-compose up -d'
                echo ("System is running..")
                
            stage "publish"
                echo ("publishing..")
                withCredentials([[
                    $class: 'UsernamePasswordMultiBinding', 
                    credentialsId: 'elastestci-dockerhub',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD']]) {
                        sh 'docker login -u "$USERNAME" -p "$PASSWORD"'
                        //here your code 
                        alluxio_image.push()
                        hadoop_image.push()
                        elasticsearch_image.push()
                        kibana_image.push()
                        cerebro_image.push()
                        mysql_image.push()
                    }


        }
}