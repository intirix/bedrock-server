Minecraft Bedrock Server

Docker image for Mojang's Bedrock server.  Mojang's server needs to run as root.

# Volumes

## Worlds

The worlds are stored in /worlds.  Map in a volume to keep your worlds around

## Configuration

The configuration is stored in /config.  When the container starts, it will check
if /config/server.properties exists.  If it doesn't exist, then a default version
will be written to it.

# Build

```
sudo docker build -t intirix/bedrock-server:latest .
```

# Run

```
sudo docker run -d -it --volume /minecraft/worlds:/worlds --volume /minecraft/config:/config \
    -p 19132:19132/udp --name minecraft_bedrock \
    --restart=unless-stopped intirix/bedrock-server:latest
```
