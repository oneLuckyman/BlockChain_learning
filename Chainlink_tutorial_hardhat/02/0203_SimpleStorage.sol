// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    // string:      字符串
    // bool:        布尔值
    // uint:        无符号整型
    // int:         整型
    // address:     区块链用户地址
    bool hasFavoriteNumber = true;
    uint256 favoriteNumber_1 = 5;
    string favoriteNumberInText = "Five";
    int256 favoriteInt = -5;
    address myAddress = 0x041CC61633274CA3dA3E27e4D6dAd8e0Be144747;
    bytes32 favoriteBytes = "cat";      // 0x-random
}