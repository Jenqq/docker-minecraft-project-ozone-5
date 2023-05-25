FROM openjdk:8-jre-alpine

ENV SERVER_ZIP=https://www.curseforge.com/minecraft/modpacks/project-ozone-3-a-new-way-forward/download/4345112

RUN apk --no-cache add wget openssl unzip bash
RUN addgroup -g 1234 minecraft
RUN adduser -D -h /data -u 1234 -G minecraft -g "minecraft user" minecraft

RUN mkdir /tmp/minecraft && cd /tmp/minecraft && \
	wget --quiet -c ${SERVER_ZIP} -O PO3+-+3.4.10server.zip && \
	unzip -q PO3+-+3.4.10server.zip && \
	rm PO3+-+3.4.10server.zip && \
	chown -R minecraft /tmp/minecraft

USER minecraft

EXPOSE 25565
EXPOSE 25575

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

ENV MOTD "Minh's first modded Minecraft :)"
ENV LEVEL world
ENV OPS applefreak_111
ENV JVM_OPTS -Xms2G -Xmx12G

CMD /start
