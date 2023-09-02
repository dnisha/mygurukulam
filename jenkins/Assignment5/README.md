## Problem statement
```
Assignment 5: 
     Create a declarative CI pipeline for java based project [spring3Hibernate] that contains various stages like
        Code checkout
        Run below stages in parallel
        - Code stability.
        - Code quality analysis.
        - Code coverage analysis.
        Generate a report for code quality & analysis.
        Publish artifacts.
        Send Slack and Email notifications.
     The user should have the option to skip various scans in the build execution. And before publish there should be an approval stage to be set in place to approve or deny the publish and if approved the step should execute and the user should be notified post successful/failed.
        
    Post completion, implement a similar pipeline for ot-microservice with mentioned stages. 
    Also, achieve the same using scripted pipeline

https://github.com/opstree/spring3hibernate
https://github.com/opstree/OT-Microservices

```

## Solution 
```

step1 - Setup sonarqube with postgresql link - https://www.vultr.com/docs/how-to-use-sonarqube-on-ubuntu-22-04-lts/

step2 -  generate token on sonarqube for integration with jenkins

step3 - install sonarqube plugin on jenkins
    note - t2.medium recommended

step4 -  add the jcoco plugin 
    link - https://www.baeldung.com/sonarqube-jacoco-code-coverage

step5 - setup nexus 
    link - https://www.fosstechnix.com/how-to-install-nexus-repository-on-ubuntu/
    note - t2.medium recommended

step6 - configure git with jenkins with pipeline job choose "Jenkinsfile" for script in job
    link - https://github.com/dnisha/spring3hibernate.git

step7 - Repeat same for below link and choose "JenkinsfileOT" for script in job
    link - https://github.com/dnisha/OT-MICROSERVICES.git

```