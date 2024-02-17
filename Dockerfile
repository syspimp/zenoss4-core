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
# NOTE: you are implicitly accepting the EULA from vmware to use resxtop
ADD resxtop-7.0.0-15992393-lin64.tgz /tmp/
# from the install.sh, excluding the man docs
RUN <<EOF
cd /tmp
tar xvf ./resxtop-7.0.0-15992393-lin64.tgz
cp -rf resxtop /usr/bin

mkdir -p /usr/lib/vmware/resxtop
cp -rf lib64/* /usr/lib/vmware/resxtop
echo "Copying libraries to /usr/lib/vmware/resxtop. Please add that folder to LD_LIBRARY_PATH"
EOF
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib/vmware/resxtop"

# zenoss4 admin console
EXPOSE 8080

# start docker-entrypoint script
ENTRYPOINT ["docker-entrypoint.sh"]
