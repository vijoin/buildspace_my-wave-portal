//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;
    mapping(address => uint256) public senderCount;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }
    
    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("I AM SMART CONTRACT");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {

        require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
        "Wait 15min");

        lastWavedAt[msg.sender] = block.timestamp;

        senderCount[msg.sender] += 1;
        totalWaves += 1;
        console.log("%s has waved with message %s!", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.timestamp + block.difficulty) % 100;
        console.log("Random # generated: %d", seed);

        /* Give a 50% chance that the user wins the prize */
        if (seed <= 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

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

//ToDo: Show Loading while waiting Txn confirmation
//ToDo: Show error message to the user when trying to spam
//ToDo: Show if they won the price or not