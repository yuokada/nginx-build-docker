FROM centos:7
MAINTAINER Yukihiro Okada
RUN yum update  -y
RUN yum install -y epel-release; \
    yum install -y autoconf automake libtool wget; \
    yum install -y git make vim less; \
    yum install -y gcc gcc-c++ pkgconfig pcre-devel tcl-devel expat-devel openssl-devel; \
    yum install -y perl-devel perl-ExtUtils-Embed GeoIP-devel libxslt-devel gd-devel; \
    yum install -y rpm-build rpmdevtools tk-devel tcl-devel expat-devel db4-devel gdbm-devel sqlite-devel bzip2-devel openssl-devel ncurses-devel readline-devel;\
    yum groupinstall -y "Development Tools" ; \
    yum clean all
# https://cwiki.apache.org/confluence/display/TS/CentOS

RUN mkdir /root/python-build
WORKDIR   /root/python-build
ENV TGZFILE python.tar.gz
RUN wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz -O $TGZFILE; \
    tar zxf  $TGZFILE
RUN cd Python-2.7.10 && ./configure --prefix=/usr/local && \
    make && make install
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python2.7
RUN git clone https://github.com/prestodb/presto-admin.git && cd presto-admin && \
    pip2.7 install .
#RUN rpmbuild --rebuild $SRPMFILE
#RUN ls -lh /root/rpmbuild/RPMS/*
#VOLUME ["/root/rpmbuild/RPMS/"]
CMD ["/bin/bash"]
