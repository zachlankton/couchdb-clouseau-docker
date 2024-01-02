FROM couchdb:3.3.3

RUN apt update && apt upgrade -y

RUN apt install gnupg ca-certificates curl

RUN curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list

RUN apt update && apt install zulu8-jdk -y

COPY clouseau /opt/clouseau

COPY docker-entrypoint.sh /usr/local/bin
COPY docker-entrypoint.sh /

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
VOLUME /opt/couchdb/data

# 5984: Main CouchDB endpoint
# 4369: Erlang portmap daemon (epmd)
# 9100: CouchDB cluster communication port
EXPOSE 5984 4369 9100
CMD ["/opt/couchdb/bin/couchdb"]