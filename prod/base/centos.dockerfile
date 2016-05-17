FROM centos:7

MAINTAINER Nathan Zimmerman, npzimmerman@gmail.com

ENV USER root
ENV HOME /root

# JAVA
ENV JAVA_HOME /usr/java/jdk1.8.0_45/jre/
ENV PATH $PATH:$JAVA_HOMEbin

RUN yum update -y && \
    yum install -y wget curl

RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.rpm" && \
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jre-8u45-linux-x64.rpm" && \
    rpm -Uvh jdk-8u45-linux-x64.rpm && \
    rpm -Uvh jre-8u45-linux-x64.rpm && \
    rm -rf jdk-8u45-linux-x64.rpm && \
    rm -rf jre-8u45-linux-x64.rpm

# MAVEN
ENV M2_HOME /usr/local/maven
ENV PATH ${M2_HOME}/bin:${PATH}

RUN wget -O /tmp/maven.tar.gz http://mirrors.gigenet.com/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar -xvf /tmp/maven.tar.gz -C /usr/local/
RUN cd /usr/local && ln -s apache-maven-3.3.9 maven

RUN useradd -ms /bin/bash hadoop
