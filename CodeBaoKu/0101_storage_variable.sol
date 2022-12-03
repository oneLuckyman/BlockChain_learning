// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SolidityTest {
    uint storedData;        // 状态变量
    constructor() {
        storedData = 10;    // 使用状态变量
    }
}