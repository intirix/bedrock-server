#!/bin/bash

for x in whitelist.json permissions.json valid_known_packs.json server.properties
do
	if [ ! -e /config/$x ]
	then
		echo /bin/cp -f /bedrock-server/orig-config/$x /config/$x
		/bin/cp -f /bedrock-server/orig-config/$x /config/$x
	fi

	if [ ! -L /bedrock-server/$x ]
	then
		echo /bin/mv -f /bedrock-server/$x /config/$x.orig
		/bin/mv -f /bedrock-server/$x /config/$x.orig
		echo /bin/ln -s /config/$x /bedrock-server/$x
		/bin/ln -s /config/$x /bedrock-server/$x
	fi
done

export LD_LIBRARY_PATH=/bedrock-server
exec /bedrock-server/bedrock_server
