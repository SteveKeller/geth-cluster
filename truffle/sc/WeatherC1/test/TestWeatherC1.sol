pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/WeatherC1.sol";

contract TestWeatherC1 {

	WeatherC1 weather = WeatherC1(DeployedAddresses.WeatherC1());

	function beforeAll() public {
		
		weather.createEntity(1527325183, "23.7", "55.2");
	}

	function testGetEntityCount() public {
		uint x = weather.getEntityCount();
		uint expected = 1;		

		Assert.equal(x, expected, "One Entry expected");
	}

}

