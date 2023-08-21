Assignment 2:
Topics Covered: (Shell Scripting, Git, Freestyle Job, Paramteters, Upstream/Downstream, Slack + Email Notification)
    Part 1:-
      Create a Jenkins job via which you will be able to perform below operations & if any of the step fails a Slack and Email notification should be sent:
      - Create a branch
      - List all branches
      - Merge one branch with other branch
      - Rebase one branch with other branch
      - Delete a branch

    Part 2:-
      Create 2 Jenkins Jobs that will:
      - Create a file
      - Add few content in the file ""<Ninja Name> from Devops Ninja""
      - Publish the content using a web server
      The second job must get triggered automatically only after successful completion of the first job.
      If any of the step fails a Slack and Email notification should be sent.
      if all jobs run successfully Slack and Email notification should be sent."


Solution - 

Part1 - 

step1 - Download email and slack plugin and setup them with credentials
step2 - Under post section setup the condition on which you want to send notification.

Part2 -

step1 - Download ansible and file text plugin
step2 - clone repo https://github.com/dnisha/nginx-playbook
step3 - take input from string perameter and send content to index.nginx-debian.html file
step4 - build the job 

Note - setup the inventory path properly