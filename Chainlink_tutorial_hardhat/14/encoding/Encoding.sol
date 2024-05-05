// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// For Remix
contract Encoding{
    function combineStrings() public pure returns(string memory) {
        return string(abi.encodePacked("Hi Mom! ", "Miss you!"));
    }
    // globally available methods % units
}