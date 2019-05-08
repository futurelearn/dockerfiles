FROM docker.elastic.co/elasticsearch/elasticsearch:5.6.0

COPY es-docker-tmpfs bin/es-docker-tmpfs

# The base image sets the user. We need root permissions to chown the file.
USER root
RUN chown elasticsearch:elasticsearch bin/es-docker-tmpfs
RUN chmod 0750 bin/es-docker-tmpfs

CMD [ "bin/es-docker-tmpfs" ]
