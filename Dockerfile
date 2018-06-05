FROM ubuntu:16.04

# update utilities and get unzip
RUN apt-get update && apt-get install -y unzip

# set work directory
WORKDIR /opt

# add binaries
COPY server-jre-8u162-linux-x64.tar.gz /opt
ADD pingfederate-9.0.3.zip /opt

# extract binaries
RUN unzip pingfederate-9.0.3.zip
RUN tar -xf server-jre-8u162-linux-x64.tar.gz

# cleanup installation files
RUN rm /opt/pingfederate-9.0.3.zip && rm /opt/server-jre-8u162-linux-x64.tar.gz

# set JAVA_HOME
ENV JAVA_HOME /opt/jdk1.8.0_162

# open PF admin ports 
EXPOSE 9999
EXPOSE 9031

# add data.zip when needed:
# ADD data.zip /opt/pingfederate-9.0.3/pingfederate/server/default/data/drop-in-deployer

# write and execut pf startup script
COPY startup.sh /usr/bin/startup.sh
RUN chmod +x /usr/bin/startup.sh
ENTRYPOINT ["/usr/bin/startup.sh"] 

# ldapsearch -W -h ldap.forumsys.com -D “uid=tesla,dc=example,dc=com” -b “dc=example,dc=com”