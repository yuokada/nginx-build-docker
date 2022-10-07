FROM centos:8.4.2105
MAINTAINER Yukihiro Okada
RUN yum update  -y
RUN yum install -y epel-release; \
    yum install -y autoconf automake libtool wget; \
    yum install -y git make vim less; \
    yum install -y gcc gcc-c++ pkgconfig pcre-devel tcl-devel expat-devel openssl-devel; \
    yum install -y perl-devel perl-ExtUtils-Embed GeoIP-devel libxslt-devel gd-devel; \
    yum install -y rpm-build ;\
    yum clean all
# https://cwiki.apache.org/confluence/display/TS/CentOS

RUN mkdir /root/ngx-build
WORKDIR /root/ngx-build
ENV SRPMFILE nginx.src.rpm
RUN wget http://nginx.org/packages/rhel/7/SRPMS/nginx-1.10.1-1.el7.ngx.src.rpm -O $SRPMFILE
RUN rpmbuild --rebuild $SRPMFILE
RUN ls -lh /root/rpmbuild/RPMS/*
VOLUME ["/root/rpmbuild/RPMS/"]
CMD ["/bin/bash"]
