//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint256) public senderCount;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }
    
    Wave[] waves;

    constructor() payable {
        console.log("I AM SMART CONTRACT");
    }

    function wave(string memory _message) public {
        senderCount[msg.sender] += 1;
        totalWaves += 1;
        console.log("%s has waved with message %s!", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getSenderCount(address senderAddress) public view returns (uint256) {
        uint256 _senderCount = senderCount[senderAddress];
        console.log("This sender has waved %d times", _senderCount);
        return _senderCount;
    }

}
