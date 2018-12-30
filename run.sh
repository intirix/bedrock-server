#!/bin/bash

if [ ! -e /config/server.properties ]
then
	/bin/cp -f /bedrock-server/server.properties.old /config/server.properties
fi

export LD_LIBRARY_PATH=/bedrock-server
exec /bedrock-server/bedrock_server
