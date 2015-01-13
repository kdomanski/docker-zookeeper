#!/bin/bash

# set client ID if given
if [ ! -z "$ZK_ID" ]; then
  echo $ZK_ID > /tmp/zookeeper/myid
fi

# set client port if given
if [ ! -z "$ZK_PORT" ]; then
  sed "s/^clientPort=.*\$/clientPort=$ZK_PORT/" -i /opt/zookeeper-$ZK_VERSION/conf/zoo.cfg
fi

# add server list if given
if [ ! -z "$ZK_SERVERS" ]; then
  # explode into array
  IFS=',' read -a arr <<< "$ZK_SERVERS"
  # if the count is even
  if [ $(expr ${#arr[@]} % 2) == 0 ]; then
    echo "Number of servers must be odd."
    exit 1
  else # odd count
    # remove current server entries
    sed '/^server\.[0-9]*=.*$/d' -i /opt/zookeeper-$ZK_VERSION/conf/zoo.cfg
    # add entries from array
    for i in ${!arr[@]}; do
      #echo "$i ${arr[i]}"
      echo "server.$(expr 1 + $i)=${arr[i]}" >> /opt/zookeeper-$ZK_VERSION/conf/zoo.cfg
    done
  fi
fi

cd /opt/zookeeper-$ZK_VERSION && /opt/zookeeper-$ZK_VERSION/bin/zkServer.sh start-foreground