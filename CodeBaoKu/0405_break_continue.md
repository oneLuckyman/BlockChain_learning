# Solidity 循环语句
## Solidity break 与 continue

### break 示例
```solidity
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
```
运行上述程序的结果为
```solidity 
0: string: 3
```

### continue 示例
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract SolidityTest {
    uint storedData;
    constructor() {
        storedData = 10;
    }

    function getResult() public pure returns(string memory){
        uint n = 1;
        uint sum = 0;

        while( n < 10){
            n++;
            if(n==5){
                continue;   // 当 n 的值是 5 时，跳过 n
            }
            sum = sum + n;
        }
        return integerToString(sum);
    }
    function integerToString(uint _i) internal pure returns (string memory){

        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;

        while (true) {
            len++;
            j /= 10;
            if(j==0){
                break;      // break 跳出循环
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
```

运行上面程序的输出结果为
```solidity
0: string: 49
```