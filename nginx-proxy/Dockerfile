FROM nginx

RUN apt-get update && apt-get install -y netcat

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

COPY default.conf /etc/nginx/default.conf.template

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
