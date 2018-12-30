FROM ubuntu:18.04

RUN apt-get update && apt-get install -y unzip curl libcurl4 libssl1.0.0
RUN curl https://minecraft.azureedge.net/bin-linux/bedrock-server-1.8.0.24.zip --output /bedrock-server.zip \
	&& unzip bedrock-server.zip -d bedrock-server \
	&& rm bedrock-server.zip \
	&& chmod 755 /bedrock-server/bedrock_server

EXPOSE 19132

COPY run.sh /run.sh
RUN chmod +x /run.sh
VOLUME /worlds
VOLUME /config
RUN /bin/rm -rf /bedrock-server/worlds && /bin/ln -s /worlds /bedrock-server/worlds
RUN /bin/mv -f /bedrock-server/server.properties /bedrock-server/server.properties.old
RUN /bin/cp -f /bedrock-server/server.properties.old /config/server.properties
RUN ln -s /config/server.properties /bedrock-server/server.properties
WORKDIR /bedrock-server
CMD /run.sh
