FROM centos:7
MAINTAINER github@wuub.net

RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum -y update

RUN yum -y groupinstall "Development Tools"
RUN yum -y install python-pip python-devel ruby ruby-devel rpm-build  
RUN yum -y install rpm-build  

RUN gem instal fpm
# upgrade python tools to the newest versions
RUN pip install -U pip virtualenv wheel setuptools

WORKDIR /build/packaging
VOLUME /build

CMD make rpm
