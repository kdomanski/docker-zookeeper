The following environmental variables will be used to reconfigure the container upon startup:

 - **ZK_PORT** -- the port to listen on for clients
 - **ZK_ID** -- this instance's ID
 - **ZK_SERVERS** -- Comma-separated list of instances within the cluster. Their number must be odd.

## Example
### Triple setup

```docker run -d --net=host -e ZK_ID=1 -e ZK_PORT=2181 --name zk1 -e ZK_SERVERS=localhost:2887:3887,localhost:2888:3888,localhost:2889:3889 kdomanski/zookeeper
docker run -d --net=host -e ZK_ID=2 -e ZK_PORT=2182 --name zk2 -e ZK_SERVERS=localhost:2887:3887,localhost:2888:3888,localhost:2889:3889 kdomanski/zookepeer
docker run -d --net=host -e ZK_ID=3 -e ZK_PORT=2183 --name zk3 -e ZK_SERVERS=localhost:2887:3887,localhost:2888:3888,localhost:2889:3889 kdomanski/zookepeer
```

### Single instance
```docker run -d -p 2181:2181 kdomanski/zookepeer```
