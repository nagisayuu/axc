#!/bin/bash
kill `ps aux | grep "geth \
--networkid 4649 \
--nodiscover \
--maxpeers 0 \
--datadir /home/vagrant/geth/eth-network \
--rpc ¥
--rpcaddr 0.0.0.0 \
--rpcport 8545 ¥
--rpccorsdomain \* \
--rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3 \
--verbosity 6" | awk  '{print $2}'`

if [ $? = 0 ]; then
  echo "geth stopped"
else
  echo "error occured when stopping geth, confirm log!"
fi
