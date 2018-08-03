# Private Ethereum Blockchain - Geth Cluster                                                              

This project provide a private ethereum blockchain based on a geth cluster with additional features.

> F1: automatically P2P discovery with a bootnode for all ethereum miners <br>
> F2: miners are scalable while runtime <br>
> F3: exposed node for interacting (additional miners, remix, web3, node-red, ...) from outside with the blockchain <br>
> F4: smart contract deployment with truffle <br>
> F5: integrated blockchain explorer <br>
> F6: some tests :) <br>

ever wanted to have your own ethereum blockchain and just play with it? <br>
...then this is the right project for you ;)

### Requirements
##### Software                                                              
* docker 18.03.0-ce <=                                                           
* docker-compose 1.21.0 <=                                                       
       
##### Ressource Recommendations
`CPU depends heavy on running miner count, default miner count is 2, each miner mines with 1 cpu thread`

Disk Space (docker dir) >= 10GB   
CPU >= 4  
Memory >= 2GB 
                                                                      
##### Prerequisites                                                             
* clone geth-cluster repo
* edit envar.env file and set environment variables for your setup
                                                                              
### Getting Started                                                                     
```sh
docker-compose up                                                             
```

Ethereum Blockchain needs about 30 minutes for bootstrapping (depends on your cpu hardware), which means to build and run all containers. Building container is only required if they are not already build once.
The ethereum network builds a DAG (directed acyclic graph) for the proof of work algorithm. The building process takes all available cpu cores from the docker host machine.
After the DAG was built miner nodes are starting mine. The DAG only needs once to get created and as long as the geth containers are not destroyed.

### Scale Miners     
```sh
docker-compose up -d --scale geth-miner=${MinerCount} --no-recreate
```

### Ethereum Accounts  
Every miner (including exposed miner) has an already existing ethereum account. The account address is located in the file **/privatechain/accID** inside each miner container.
The account will be generated when the miner containers are first started. The password is predefined in the file **geth-miner/passfile** in the geth-cluster git repository.

### Testing

> Tested with: Debian Stretch (9.4) | docker 18.03.0-ce | docker-compose 1.21.0  

The geth cluster needs some time to bootstrap and get the ethereum network ready. 
Tests can fail if they are executed to fast after the docker-compose is started.

##### Build test container
```sh
docker build -t testing-1 testing
```

##### Run test container and attach to existing compose network
```sh
docker run -it --network=geth-cluster_overlay --env-file envar.env testing-1
```

### Deployment Smart Contract   
##### Build truffle deployment container
```sh
docker build -t truffle-1 truffle
```

##### Run truffle container and attach to existing compose network
```sh
docker run -it -w /dapp/${WorkDirSmartContract} --network=geth-cluster_overlay truffle-1 migrate --network geth-chain
```
