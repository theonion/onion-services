#
# Taken from the ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM java:8

ENV ES_PKG_NAME elasticsearch-1.4.4

# Install ElasticSearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Define mountable directories.
VOLUME ["/data"]
RUN mkdir /plugins

# Mount elasticsearch.yml config
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml
# Install AWS plugin (for S3 snapshot support)
RUN /elasticsearch/bin/plugin --install elasticsearch/elasticsearch-cloud-aws/2.4.1

# Workaround for AWS authentication error caused by older JodaTime < 2.8.1
# REFS:
#   http://stackoverflow.com/questions/32058431
#   https://github.com/aws/aws-sdk-java/issues/484
RUN rm /plugins/cloud-aws/joda-time-2.5.jar
RUN curl -sL --retry 3 "http://central.maven.org/maven2/joda-time/joda-time/2.8.2/joda-time-2.8.2.jar" -o /plugins/cloud-aws/joda-time-2.8.2.jar

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
