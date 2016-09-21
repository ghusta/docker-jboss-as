# Inspired from jboss/wildfly
FROM jboss/base-jdk:7
MAINTAINER Guillaume Husta (@ghusta)

ENV JBOSS_MAJOR_MINOR_VERSION 7.1
ENV JBOSS_VERSION 7.1.1.Final
ENV JBOSS_SHA1 fcec1002dce22d3281cc08d18d0ce72006868b6f
ENV JBOSS_SHA256 88fd3fdac4f7951cee3396eff3d70e8166c3319de82d77374a24e3b422e0b2ad
ENV JBOSS_HOME /opt/jboss/jboss-as

WORKDIR /opt/jboss
RUN curl -O https://download.jboss.org/jbossas/$JBOSS_MAJOR_MINOR_VERSION/jboss-as-$JBOSS_VERSION/jboss-as-$JBOSS_VERSION.tar.gz \
    && sha256sum jboss-as-$JBOSS_VERSION.tar.gz | grep $JBOSS_SHA256 \
    && tar xf jboss-as-$JBOSS_VERSION.tar.gz \
    && mv jboss-as-$JBOSS_VERSION $JBOSS_HOME \
    && rm jboss-as-$JBOSS_VERSION.tar.gz

# Delete *.bat (Windows)
RUN rm $JBOSS_HOME/bin/*.bat

# Add volume for log files
# If having permission denied, see here : https://goldmann.pl/blog/2014/07/18/logging-with-the-wildfly-docker-image/#_permission_denied
VOLUME $JBOSS_HOME/standalone/log

# TODO: Add volume for config files ?
# VOLUME ...

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown (process in foreground or background)
ENV LAUNCH_JBOSS_IN_BACKGROUND true

EXPOSE 8080
EXPOSE 9990

CMD ["/opt/jboss/jboss-as/bin/standalone.sh", "-b", "0.0.0.0"]
