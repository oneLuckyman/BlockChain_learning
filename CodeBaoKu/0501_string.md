# Solidity 字符串

Solidity 中，字符串值使用双引号(")和单引号(')包括，字符串类型用 string 表示。

字符串是特殊的数组，是引用类型

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    string public data = "test";
}
```

在上面的例子中，"test" 是一个字符串，data 是一个字符串变量。

Solidity 提供字节与字符串之间的内置转换，可以将字符串赋给 bytes 类型变量。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    bytes public data = "test";
}
```

## 转义字符

Solidity 字符串类型支持的转义字符，如下表所示：
<!-- 这里有一个表格 -->

## bytes 到字符串的转换

可以使用 string() 构造函数将 bytes 转换为字符串。

```solidity
bytes memory bstr = new bytes(10);
string message = string(bstr);
```

示例

bytes 到字符串的转换：

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    string public data;
    bytes bstr = new bytes(2);
    function trans() external{
        bstr[0] = 'a';
        bstr[1] = 'b';
        data = string(bstr);
    }
}
```

运行上述程序，调用 trans 后，查看 data：

```solidity
0: string: ab
```

### 字符串到 bytes 的转换

可以使用 bytes() 构造函数将字符串转换为 bytes。

示例

字符串到 bytes 的转换：

```solidity 
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    constructor(){
    }

    function getResult(string memory s) public pure returns(bytes memory){
        return bytes(s);    // 字符串转换到 bytes
    }
}
```
