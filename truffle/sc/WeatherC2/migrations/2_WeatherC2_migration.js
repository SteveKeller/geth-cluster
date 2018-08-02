var weather = artifacts.require("WeatherC2");

module.exports = function(deployer) {
	deployer.deploy(weather, {
		gas: 2000000 
	});
};

