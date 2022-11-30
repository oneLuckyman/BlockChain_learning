// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    uint storedData;

    constructor() {
        storedData = 10;
    }

    function getResult() public pure returns(string memory){
        uint a = 1;
        uint b = 2;
        uint result = a + b;
        return integerToString(result);
    }

    function integerToString(uint _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;

        while (true) {
            len++;
            j /= 10;
            if(j==0){
                break;  // break 语句跳出循环
            }
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;

        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
}