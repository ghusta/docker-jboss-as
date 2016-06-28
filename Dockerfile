# Inspired from jboss/wildfly
FROM jboss/base-jdk:7
MAINTAINER Guillaume Husta

ENV JBOSS_VERSION 7.1.1.Final
# TODO: sha1 sum
ENV JBOSS_SHA1 xxx
ENV JBOSS_HOME /opt/jboss/jboss-as

WORKDIR /opt/jboss

# Local archive for the moment...
COPY jboss-as-$JBOSS_VERSION.tar.gz .
RUN tar xf jboss-as-$JBOSS_VERSION.tar.gz \
    && mv jboss-as-$JBOSS_VERSION $JBOSS_HOME \
    && rm jboss-as-$JBOSS_VERSION.tar.gz

EXPOSE 8080

CMD ["/opt/jboss/jboss-as/bin/standalone.sh", "-b", "0.0.0.0"]
