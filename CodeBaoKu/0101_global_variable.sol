// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    // 获取当前区块号、时间戳、调用者地址
    function getGlobalVars() public view returns(uint, uint, address){
        return (block.number, block.timestamp, msg.sender);
    }
}