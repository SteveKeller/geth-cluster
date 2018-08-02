#!/bin/sh

sed "s/var GETH_HOSTNAME = \"localhost\";/var GETH_HOSTNAME = \"$DOCKER_HOST_IP\";/g" app/app.js > app/apptmp.js
sed "s/var GETH_RPCPORT = 8545;/var GETH_RPCPORT = $GETH_RPCPORT;/g" app/apptmp.js > app/app.js
rm -f app/apptmp.js
npm start
