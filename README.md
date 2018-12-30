

# Build

sudo docker build -t intirix/bedrock-server:latest .

# Run

sudo docker run -d -it --volume /minecraft/worlds:/worlds --volume /minecraft/config:/config \
    -p 19132:19132/udp --name minecraft_bedrock \
    --restart=unless-stopped intirix/bedrock-server:latest
