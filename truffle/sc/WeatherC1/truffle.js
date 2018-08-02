module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
	  "geth-chain": {
		  network_id: 65534,
		  host: "172.16.0.3",
		  port: 8545,
		  gas: 2000000,
		  gasPrice: 2000000,
	  }
  }

};
