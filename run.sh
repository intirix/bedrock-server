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

if [ ! -L /bedrock-server/allowlist.json ]
then
	echo "/bin/mv -f /bedrock-server/allowlist.json /config/allowlist.json.orig"
	/bin/mv -f /bedrock-server/allowlist.json /config/allowlist.json.orig
	echo /bin/ln -s /config/whitelist.json /bedrock-server/allowlist.json
	/bin/ln -s /config/whitelist.json /bedrock-server/allowlist.json
fi

#export LD_LIBRARY_PATH=/bedrock-server
exec /bedrock-server/bedrock_server
