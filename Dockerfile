FROM dockerfile/java:openjdk-7-jre
MAINTAINER Kamil Domański <kamil@domanski.co>

RUN mkdir /tmp/zookeeper

ENV ZK_VERSION 3.4.6

RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz | tar xzf - -C /opt && \
  cp /opt/zookeeper-$ZK_VERSION/conf/zoo_sample.cfg /opt/zookeeper-$ZK_VERSION/conf/zoo.cfg

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

