// Jasmine Test File for geth cluster

var dockerip = process.env.DOCKER_HOST_IP;

// Geth-Exposed | Blockchain Testing
describe("Ethereum Blockchain:", function() {
	var Web3 = require('web3');
	const isPortReachable = require('is-port-reachable');

	it("geth-exposed testing if endpoint port 8545 is open", function() {         
	        return isPortReachable(8545, {host: 'geth-exposed'}).then(function(result) {
		  expect(result).toBe(true, "because the flux capacitor has gone bad.");
		});
	});

	describe('Exposed RPC Endpoint, ',function(){
		
		it("testing web3 connectivity", function() {
	  	 	
			return isPortReachable(8545, {host: 'geth-exposed'}).then(function(result) {
				
				if(result){
					if (typeof web3 !== 'undefined') {
	    					web3 = new Web3(web3.currentProvider);
	  				} else {
	    					// set the provider you want from Web3.providers
  	    					web3 = new Web3(new Web3.providers.HttpProvider("http://" + dockerip + ":8545"));
	  				}
					expect(web3.isConnected()).toBe(true, "web3 api not connectable");

				} else {
					fail("can not run this test because port 8545 is not reachable");
				}
			});
		});
	});

	describe('Testing Blockchain, ',function(){
	
		it("should be ready for use", function() {
          		return isPortReachable(8545, {host: 'geth-exposed'}).then(function(result) {
				
				if(result){
					if (typeof web3 !== 'undefined') {
	    					web3 = new Web3(web3.currentProvider);
	  				} else {
	    					// set the provider you want from Web3.providers
  	    					web3 = new Web3(new Web3.providers.HttpProvider("http://" + dockerip + ":8545"));
	  				}

					// peer Count with exposed node and another miner is 1 
					expect(web3.net.peerCount).toBeGreaterThan(0, "blockchain peer count to low, peers are not connected with each other");

					// listening of miner should be true for networking connectivity	
					expect(web3.net.listening).toBe(true, "geht miner not listening for other peers");

					// miner should be mining :)
					expect(web3.eth.mining).toBe(true, "geth miner ist not mining");

					// block number should be bigger than 2 after blockchain started
					expect(web3.eth.blockNumber).toBeGreaterThan(2, "counted block numbers to low, should be at least 3 blocks, give it some time to mine ;) ");
				} else {
					fail("can not run this test because port 8545 is not reachable");
				}
			});

		});
	});
});

// Geth Miner Network Testing
describe("Geth-Miner RPC Service:", function() { 
     	var Web3 = require('web3');
	const isPortReachable = require('is-port-reachable');

	it("testing if port 8545 is open", function() {         
	        return isPortReachable(8545, {host: 'geth-miner'}).then(function(result) {
		  expect(result).toBe(true, "because the flux capacitor has gone bad.");
		});
	});

});

// Ethexplorer Testing
describe("Ethexplorer Web Service:", function() { 
     
	const isPortReachable = require('is-port-reachable');

	it("testing if port 8000 is open", function() {         
	        return isPortReachable(8000, {host: 'ethexplorer'}).then(function(result) {
			expect(result).toBe(true, "because the flux capacitor has gone bad.");
		});
	});

	it("web service should return 200", function(done) {
		var request = require('request');
		request.get('http://ethexplorer:8000', function (err, res, body){
			if (res === undefined) {
				fail("get request not possible");
			} else {
				expect(res.statusCode).toBe(200, "http response code mismatch");
			}
			done();
		});
	});
}); 
