//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint256) public senderCount;
    

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function wave() public {
        senderCount[msg.sender] += 1;
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
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
