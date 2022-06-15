pragma solidity ^0.4.24;

contract slot {
    uint256 secret;
    address watcher;

    struct Luck {
        uint256 luckNumber;
        address luckOne;
    }

    Luck luck0;

    mapping(address => uint) public balanceOf;
    mapping(address => uint) public gift;

    event SendFlag(string name);

    constructor() public {
        setSecret();
    }

    function payforflag(string name) public {
        require(balanceOf[msg.sender] >= 1000000000);
        balanceOf[msg.sender]=0;
        setSecret();
        emit SendFlag(name);
    }

    function setSecret() internal {
        uint256 seed = uint256(keccak256(abi.encodePacked(block.number)))+uint256(keccak256(abi.encodePacked(block.timestamp)));
        secret = uint256(keccak256(abi.encodePacked(seed)));
    }

    function drop(uint _secret) public {
        require(secret == _secret);
        require(gift[msg.sender] == 0);
        balanceOf[msg.sender] += 1;
        gift[msg.sender] = 1;
    }

    function bet() public {
        require(balanceOf[msg.sender] > 0);
        require(balanceOf[msg.sender]-2 > 0);
        balanceOf[msg.sender]-=2;
    }
}