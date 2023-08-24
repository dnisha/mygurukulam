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