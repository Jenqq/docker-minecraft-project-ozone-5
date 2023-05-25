FROM openjdk:8-jre-alpine

ENV SERVER_ZIP=https://www.curseforge.com/api/v1/mods/256289/files/4345112/download

RUN apk --no-cache add wget openssl unzip bash
RUN addgroup -g 1234 minecraft
RUN adduser -D -h /data -u 1234 -G minecraft -g "minecraft user" minecraft

RUN mkdir /tmp/minecraft && cd /tmp/minecraft && \
	wget --quiet -c ${SERVER_ZIP} -O PO3+-+3.4.11Fserver.zip && \
	unzip -q PO3+-+3.4.11Fserver.zip && \
	rm PO3+-+3.4.11Fserver.zip && \
	chown -R minecraft /tmp/minecraft

USER minecraft

EXPOSE 25565
EXPOSE 25575

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

ENV MOTD "Yourmum"
ENV LEVEL world
ENV OPS applefreak_111
ENV JVM_OPTS -Xms2G -Xmx12G

CMD /start
