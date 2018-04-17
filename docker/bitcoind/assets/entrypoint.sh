#!/bin/sh
set -e

mkdir -p "$BITCOIN_DATA"
chmod 700 "$BITCOIN_DATA"
chown -R bitcoin "$BITCOIN_DATA"

echo "$0: assuming arguments for bitcoind $@"

set -- bitcoind $@ -txindex=1 -peerbloomfilters=0  \
        -rpcallowip=10.0.0.0/8 -rpcallowip=172.16.0.0/12 -rpcallowip=192.168.0.0/16 \
        -rpcuser=$BITCOIN_RPC_USER -rpcpassword=$BITCOIN_RPC_PASSWORD

echo "$0: setting data directory to $BITCOIN_DATA"

set -- "$@" -datadir="$BITCOIN_DATA"
echo "$@"
exec gosu bitcoin "$@"

