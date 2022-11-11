// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {

    uint256 public minimumUsd = 50;

    function fund() public payable{
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        
        require(msg.value > minimumUsd, "Didn't send enough!");
    }

    function getPrice() public {
        // ABI
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e 
    }

    function getConversionRate() public {}

    // function withdraw(){}
}