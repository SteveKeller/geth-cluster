# User Manual - Private Ethereum Blockchain                                                              
                                                                              
### Requirements
##### Software                                                              
* Docker 18.03.0-ce <=                                                           
* Docker Compose 1.21.0 <=                                                       
       
##### Ressource Recommendations
`CPU depends heavy on running miner count, default miner count is 2, each miner mines with 1 cpu thread`

Disk Space (Docker Dir) >= 20GB   
CPU >= 4  
Memory >= 2GB 
                                                                      
##### Prerequisites                                                             
edit envar.env file and set environment variables for your setup
                                                                              
### Basic Usage                                                                     
```sh
docker-compose up                                                             
```

Ethereum Blockchain needs about 30 minutes for bootstrapping, which means to build and run all containers. Building Container is only required if they are not already build once.
The ethereum network builds a DAG (directed acyclic graph) for the proof of work algorithm. The building process takes all available cpu cores from the docker host machine.
After the DAG is built the ethereum miner node are starting with the mining. The DAG only needs once to get created and as long the geth container are not destroyed.

### Scale Miners     
```sh
docker-compose up -d --scale geth-miner=${MinerCount} --no-recreate
```

### Ethereum Accounts  
Every miner (including exposed miner) has an already existing ethereum account. The account address is located in the file **/privatechain/accID** inside each miner container.
The account will be generated when the miner containers are first started. The password is predefined in the file **geth-miner/passfile** in the EtheRed git repository.

### Plattform Tests

EtheRed Plattform needs some time to bootstrap and get the ethereum network ready. 
Tests can fail if they are executed to fast after the EtheRed Plattform is started.

##### Build test container
```sh
docker build -t ethered-tests testing
```

##### Run test container and attach to existing compose network
```sh
docker run -it --network=bda-code_overlay --env-file envar.env ethered-tests
```

### Deployment Smart Contract   
##### Build truffle deployment container
```sh
docker build -t truffle-1 truffle
```

##### Run truffle container and attach to existing compose network
```sh
docker run -it -w /dapp/${WorkDirSmartContract} --network=bda-code_overlay truffle-1 migrate --network geth-chain
```
