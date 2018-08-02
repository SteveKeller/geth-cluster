var weather = artifacts.require("WeatherC1");

module.exports = function(deployer) {
	deployer.deploy(weather, {
	  gas: 2000000
	});
};

