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

    constructor() {
        console.log("I AM SMART CONTRACT");
    }

    function wave(string memory _message) public {
        senderCount[msg.sender] += 1;
        totalWaves += 1;
        console.log("%s has waved with message %s!", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);
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
