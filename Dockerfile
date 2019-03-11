FROM alpine

RUN apk add curl

ADD ./elk-cleaner.sh /opt/elk-cleaner.sh
RUN chmod +x /opt/elk-cleaner.sh

ENTRYPOINT ["/opt/elk-cleaner.sh"]