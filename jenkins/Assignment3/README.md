Assignment 3:
Topics Covered:  (Configuring Agents, Various Menthods, Distributing Loads, Executors, Assigning Nodes)
     Assignment on configuring Nodes
        Configure a Ubuntu node using execution of command on the master method. 
        - Make sure at any point of time maximum 5 jobs can be executed on this node.
        - Assign this node to Assignment 2: Part 1 
        Configure a RHEL node using  Launch slave agents via SSH method. 
        - Make sure at any point of time maximum 2 jobs can be executed on this node.
        - Assign this node to Assignment 2: Part 2
        Configure a CentOS node using Launch slave agents via SSH method. 
        - Make sure at any point of time maximum 3 jobs can be executed on this node.
        - Assign this node to Assignment 3
        Configure a Windows node using method of your choice
        - Download one sample  application of .NET and build it on Windows Node.

Link - https://medium.com/@DevOpsfreak/how-to-configure-jenkins-slave-nodes-by-launching-agents-via-ssh-or-launch-agent-via-execution-of-a0cf6d6dd032


Solution - 

* Ubuntu agent connectivity

step1 - setup the jenkins master
step2 - download the slave.jar into slave machine 

        sudo wget http://<slave-ip>:8080/jnlpJars/slave.jar 

step3 - provide execute permission
step4 - In the agent configure section choose execution of command on the master method and paste command

        ssh ubuntu@<slave-ip> java -jar /home/ubuntu/workspace/slave.jar

step5 - Ubuntu node get connected

* Windows agent connectivity

step1 - setup the jenkins master
step2 - configure windows agent node with workdir and lable
step3 - save and close the configuration 
step4 - paste the command onto widows command

        java -jar agent.jar -jnlpUrl http://<your-jenkins-server>/computer/<agent-name>/slave-agent.jnlp -secret <your-secret>
