pragma solidity ^0.4.24;

contract WeatherC2 {
    
    address owner;
    //uint constant price = 1 ether;
    mapping (address => WeatherStation) private stations;

    struct WeatherStation {
        address stationAddress;
        string name;
        address[] accessList;
        string temperature;
        string humidity;
        string picture;
        string livestream;
        uint price;
    }
    
    WeatherStation[] private addressList;
  
  
    constructor() public {
        owner = msg.sender;
    }
    
    //checks if the owner tries to execute the function
    modifier onlyBy {
        require(msg.sender == owner, "not owner");
        _;
    }

    //If the delivered station address is on the accesslist the function will be executed
    modifier onAccessList(address sAddress) {
        bool x;
        x = true;
        
        for(uint i = 0; i < stations[sAddress].accessList.length; i++){
            
            if (stations[sAddress].accessList[i] == msg.sender){
                x = false;
                _;
            }
        }
        if (x){
            revert("not on accesslist");    
        }
        
    }
    
    //If the delivered station address is NOT on the accesslist the function will be executed
    modifier notOnAccessList(address sAddress) {
        
        for(uint i = 0; i < stations[sAddress].accessList.length; i++){
            
            if (stations[sAddress].accessList[i] == msg.sender){
                revert("Already paid");
            }
        }
        _;
    }
    
    //checks if mapping is already set
    modifier addressNotZero() {
        require(stations[msg.sender].stationAddress == address(0x0), "Mapping already set");
        _;
    }

    //Creates a new Weather Station. Can only be executed once per Station
    function createStation(string name) public addressNotZero {
        WeatherStation memory ws;
        ws.stationAddress = msg.sender;
        ws.name = name;
        addressList.push(ws);
        stations[msg.sender] = ws;
    }
    
    //The Weather Station can only update references for itself (msg.sender)
    function updateReference(string tem, string hum, string pic, string live) public {
        stations[msg.sender].temperature = tem;
        stations[msg.sender].humidity = hum;
        stations[msg.sender].picture = pic;
        stations[msg.sender].livestream = live;
    }
    
    function updatePrice(uint price) public {
        stations[msg.sender].price = price * 1000000000000000000;
    }

    //function to pay for the data. Can be executed only once per account.
    function pay(address sAddress) public notOnAccessList(sAddress) payable {
        if (msg.value != stations[sAddress].price || msg.value == 0) {
           revert("Not enough Ether");
        }
        
        stations[sAddress].accessList.push(msg.sender);
        sAddress.transfer(stations[sAddress].price);
    }
    
    //Returns data references, checks if account already paid.
    function getReference(address sAddress) public constant onAccessList(sAddress) returns(string, string, string, string) {
        return(stations[sAddress].temperature, stations[sAddress].humidity, stations[sAddress].picture, stations[sAddress].livestream);
    }
    
    //Returns
    function getStations(uint nr) public constant returns(address, string) {
        return (addressList[nr].stationAddress, addressList[nr].name);
    }
    
    //returns station count
    function getStationCount() public constant returns(uint) {
        return (addressList.length);
    }


    //Destroys this smart contract, all funds of this smart contracts gets back to owner (should be nothing)
    function destroyContract() public onlyBy {
        selfdestruct(owner);
    }

}
