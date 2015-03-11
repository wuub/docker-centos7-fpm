FROM centos:7
MAINTAINER github@wuub.net

RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN rpm -iUvh http://dl.iuscommunity.org/pub/ius/stable/CentOS/7/x86_64/ius-release-1.0-13.ius.centos7.noarch.rpm
RUN yum -y update

RUN yum -y groupinstall "Development Tools"
RUN yum -y install python-pip python-devel ruby ruby-devel rpm-build  
RUN yum -y install python34u python34u-pip python34u-devel python34u-wheel  
RUN yum -y install rpm-build  

RUN gem instal fpm
# upgrade python tools to the newest versions
RUN pip install -U pip virtualenv wheel setuptools
RUN pip3.4 install -U pip virtualenv wheel setuptools
RUN yum -y -v install mariadb-devel libevent-devel libxslt-devel

RUN mkdir -p /build/packaging
WORKDIR /build/packaging
VOLUME /build 

ENV RPMUID 0

CMD make rpm && chown $RPMUID:$RPMUID *.rpm && mv *.rpm .. && make clean
