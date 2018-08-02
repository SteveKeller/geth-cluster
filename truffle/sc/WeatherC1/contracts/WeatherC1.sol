pragma solidity ^0.4.24;

contract WeatherC1 {

  struct WeatherData {
    uint date;
    string temperature;
    string humidity;
  }
  
  //Array with all WeatherData
  WeatherData[] private entityStructs;
  
  modifier checkLength {
      require(entityStructs.length != 0);
      _;
  }

  //Creates a new struct and adds it to the array. date as integer because of unix timestamp
  //temperature and humidity as string because of missing float in solidity
  function createEntity(uint date, string temperature, string humidity) public {
    WeatherData memory newEntity;
    newEntity.date = date;
    newEntity.temperature = temperature;
    newEntity.humidity = humidity;
    entityStructs.push(newEntity);
  }
  
  //Returns the length of the array
  function getEntityCount() public constant returns(uint entityCount) {
    return entityStructs.length;
  }
  
  //Returns one Temperature entry
  function getTemperatureByNumber(uint nr) public constant returns(string){
      return entityStructs[nr].temperature;
  }
  
  //Returns one Humidity entry
  function getHumidityByNumber(uint nr) public constant returns(string){
      return entityStructs[nr].humidity;
  }

  //Returns a full struct out of the array
  function getAllByNumber(uint nr) public constant returns(uint, string, string){
      return(entityStructs[nr].date, entityStructs[nr].temperature, entityStructs[nr].humidity);
  }
  
  //Returns allways the last entry in the array
  function getLastEntry() public constant checkLength returns(uint, string, string){
      uint nr = entityStructs.length - 1;
      return(entityStructs[nr].date, entityStructs[nr].temperature, entityStructs[nr].humidity);
  }
}
