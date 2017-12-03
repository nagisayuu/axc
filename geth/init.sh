#!/bin/bash
geth \
--datadir /home/vagrant/geth/eth-network \
init /home/vagrant/geth/genesis.json

if [ $? = 0 ]; then
  echo "geth init succeeded"
else
  echo "error occured when initializing geth, confirm log!"
fi
