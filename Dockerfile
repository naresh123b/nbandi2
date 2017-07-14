FROM centos:7
#install packs
RUN yum install -y httpd
RUN yum install -y centos-release-scl
RUN yum install -y python27
RUN yum install -y java-1.8.0-openjdk
ADD apache-cassandra-3.9/bin/cassandra /usr/local/bin
ADD cassandra.sh /usr/local
ADD cassandra1.sh /usr/local
ADD TOD-script.cql /usr/local
RUN chmod 755 /usr/local/cassandra.sh
RUN chmod 755 /usr/local/cassandra1.sh
RUN chmod 755 /usr/local/TOD-script.cql
EXPOSE 7000 7001 7199 9042 9160
WORKDIR /naresh/apache-cassandra-3.9/bin
CMD ["/usr/local/cassandra.sh"]
