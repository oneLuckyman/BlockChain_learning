// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    function sum() public view returns(uint){
        uint a = 1;     // 局部变量
        uint b = 2;
        uint result = a + b;
        return result;  // 访问局部变量
    }
}