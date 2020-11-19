############################################################
# Dockerfile - Zenoss v4.2.5-2108-03c on Debian Wheezy
# https://github.com/syspimp/openshift-zenoss4
############################################################

# set base image debian wheezy
#FROM debian:wheezy
FROM mcroth/docker-zenoss4

# file maintainer author
MAINTAINER david taylor <dataylor@redhat.com>

ENV ZENOSSHOME="/home/zenoss"
ENV ZENHOME="/usr/local/zenoss"

# patch ssh troubles
ADD ssh_fixes/test/* /opt/zenoss/lib/python/twisted/conch/test/
ADD ssh_fixes/ssh/* /opt/zenoss/lib/python/twisted/conch/ssh/

# zenoss4 admin console
EXPOSE 8080

# start docker-entrypoint script
ENTRYPOINT ["docker-entrypoint.sh"]
