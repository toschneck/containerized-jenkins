# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM ubuntu:16.04

MAINTAINER Tobias Schneck "tobias.schneck@consol.de"
ENV REFRESHED_AT 2016-09-16

# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd
WORKDIR /home/jenkins

### Install JNLP jenkins-slave
ARG swarmVersion=2.2
ENV JENKINS_MASTER_URL=http://jenkinsmaster:8080
ENV JENKINS_JNLP_USER=node
ENV JENKINS_JNLP_PW=node
# additional arguments vor java -jar /home/jenkins/slave.jar
ENV JENKINS_SLAVE_ADD_ARG=

# Install some basic libs and JDK8
RUN apt-get update && \
    apt-get install -y curl wget zip software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer oracle-java8-set-default && \
    rm -rf /var/lib/apt/lists/*

COPY jenkins-slave.sh /home/jenkins/jenkins-slave.sh
RUN chmod +x /home/jenkins/jenkins-slave.sh && \
    wget -O /home/jenkins/slave.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$swarmVersion/swarm-client-$swarmVersion-jar-with-dependencies.jar

### use user JENKINS and adjust user for home folder
RUN chown jenkins:jenkins -hR /home/jenkins/
USER jenkins

ENTRYPOINT ["/home/jenkins/jenkins-slave.sh"]
