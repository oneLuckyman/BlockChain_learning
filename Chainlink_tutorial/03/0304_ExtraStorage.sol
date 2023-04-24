// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./0304_SimpleStorage.sol";

// 使用 is 声明一个合约继承自另一个合约
contract ExtraStorage is SimpleStorage {
    // 使用 override 可以重载父合约中的 virtual 函数
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}