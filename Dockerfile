FROM ubuntu:22.04

ENV BEDROCK_SERVER_VERSION=1.21.41.01
RUN apt-get update && apt-get upgrade -y && apt-get install -y unzip curl libcurl4
RUN   curl https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-$BEDROCK_SERVER_VERSION.zip \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: no-cache' \
  -H 'pragma: no-cache' \
  -H 'priority: u=0, i' \
  -H 'referer: https://www.minecraft.net/en-us/download/server/bedrock' \
  -H 'sec-ch-ua: "Google Chrome";v="129", "Not=A?Brand";v="8", "Chromium";v="129"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36'> /bedrock-server.zip \
	&& unzip bedrock-server.zip -d bedrock-server \
	&& rm bedrock-server.zip \
	&& chmod 755 /bedrock-server/bedrock_server
#
#RUN curl https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.41.01.zip --output /bedrock-server.zip \
	#&& unzip bedrock-server.zip -d bedrock-server \
	#&& rm bedrock-server.zip \
	#&& chmod 755 /bedrock-server/bedrock_server

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
