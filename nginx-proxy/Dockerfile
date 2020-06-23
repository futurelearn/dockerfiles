FROM nginx

RUN apt-get update && apt-get install -y netcat curl

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

COPY default.conf /etc/nginx/default.conf.template
COPY maintenance.conf /etc/nginx/maintenance.conf.template

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
