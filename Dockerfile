FROM ubuntu:18.04

ENV BEDROCK_SERVER_VERSION=1.14.0.9
RUN apt-get update && apt-get install -y unzip curl libcurl4 libssl1.0.0
RUN curl https://minecraft.azureedge.net/bin-linux/bedrock-server-$BEDROCK_SERVER_VERSION.zip --output /bedrock-server.zip \
	&& unzip bedrock-server.zip -d bedrock-server \
	&& rm bedrock-server.zip \
	&& chmod 755 /bedrock-server/bedrock_server

EXPOSE 19132/udp
RUN mkdir -p /bedrock-server/orig-config \
	&& /bin/cp /bedrock-server/*.json /bedrock-server/orig-config/ \
	&& /bin/cp /bedrock-server/*.properties /bedrock-server/orig-config/

COPY run.sh /run.sh
RUN chmod +x /run.sh
VOLUME /worlds
VOLUME /config
RUN /bin/rm -rf /bedrock-server/worlds && /bin/ln -s /worlds /bedrock-server/worlds
WORKDIR /bedrock-server
CMD /run.sh
