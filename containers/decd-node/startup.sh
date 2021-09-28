#!/bin/sh -x

if [ -f ~/.decimal/daemon/config/genesis.json ]; then
        decd start
else
	decd init de-node --network mainnet --chain-id decimal-mainnet-08-01
	decd start
fi

