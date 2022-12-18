# Solidity if...else if... 语句

语法

```solidity
if (条件表达式 1) {
    被执行语句(如果条件 1 为真)
} else if (条件表达式 2) {
    被执行语句(如果条件 2 为真)
} else if (条件表达式 3) {
    被执行语句(如果条件 3 为真)
} else {
    被执行语句(如果所有条件为假)
}
```

示例:

```solidity 
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract SolidityTest {
    uint storedData;    // State variable
    constructor() {
        storedData = 10;
    }
    function getResult() public pure returns(string memory) {
        uint a = 1;
        uint b = 2;
        uint c = 3;
        uint result;

        if ( a > b && a > c) {  // if else if 语句
            result = a;
        } else if ( b > a && b > c) {
            result = b;
        } else {
            result = c;
        }
        return integerToString(result);
    }
    function integerToString(uint _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;

        while (j != 0) {
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
```

运行上述程序，输出结果：

```solidity
0: string: 3
```