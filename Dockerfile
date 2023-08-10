FROM        centos:7
RUN         yum install epel-release -y
RUN         yum install git -y
ADD         https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo /etc/yum.repos.d/mongodb.repo
RUN         yum install mongodb-org-shell -y
RUN         yum install mysql -y
COPY        run.sh /run.sh
ENTRYPOINT  ["bash", "/run.sh"]
