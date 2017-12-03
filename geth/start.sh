#!/bin/bash
nohup geth \
--networkid 4649 \
--nodiscover \
--maxpeers 0 \
--datadir /home/vagrant/geth/eth-network \
--rpc \
--rpcaddr "0.0.0.0" \
--rpcport 8545 \
--rpccorsdomain "*" \
--rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" \
--verbosity 6 \
2>> /home/vagrant/geth/log/geth.log &

if [ $? = 0 ]; then
  echo "geth started"
else
  echo "error occured when starting geth, confirm log!"
fi
