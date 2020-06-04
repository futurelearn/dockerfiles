FROM traefik

RUN echo -e "http://nl.alpinelinux.org/alpine/v3.11/main\nhttp://nl.alpinelinux.org/alpine/v3.11/community" > /etc/apk/repositories && \
  apk add --update libintl && \
  apk add --virtual .deps gettext && \
  cp /usr/bin/envsubst /usr/local/bin/envsubst && \
  apk del .deps

COPY traefik.yaml /etc/traefik/traefik.yaml.template
COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["traefik", "--api=false"]
