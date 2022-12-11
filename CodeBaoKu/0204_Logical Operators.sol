// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    uint storedData;
    constructor() {
        storedData = 10;
    }
    function getResult() public pure returns(string memory){
        uint a = 2;     // 局部变量
        uint b = 2;
        uint result = a & b;    // 位与
        return integerToString(result);
    }
    function integerToString(uint _i) internal pure returns (string memory) {
        if(_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;

        while (J!=0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;

        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);    // 访问局部变量
    }
}