# Solidity 回退函数 fallback

solidity 回退函数 fallback 没有参数、没有返回值。

solidity 回退函数在两种情况被调用。：

- 向合约转账，发送 Eth，就会执行 Fallback 函数
- 如果请求的合约方法不存在，就会执行 Fallback 函数

## 向合约转账

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fallback {
    event eventFallback(string);

    fallback() external payable {
        emit eventFallback("fallback");
    }

    // 查看合约账户余额
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}
```

我们向合约 Fallback 发送一笔 123 wei 的交易，查看日志：

```solidity
[
{
"from": "0xd457540c3f08f7F759206B5eA9a4cBa321dE60DC",
"topic": "0x39684f4c14ee0aafaa34ed83629676cd0fbe71653659c3353ef0c33f630e7eab",
"event": "eventFallback",
"args": {
"0": "fallbak"
}
}
]
```

我们调用合约 Fallback 的 getBalance 方法，查看合约地址的余额为 123 wei。

## 请求的合约方法不存在 

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fallback {
    event eventFallback(string);

    fallback() external payable {
        emit eventFallback("fallback");
    }
}

contract SolidityTest {
    // 外部合约
    address private fb;

    constructor(address addr) {
        fb = addr;
    }

    function callFallback() external view returns(string memory) {
        // 调用合约 Fallback 不存在的方法 echo()
        bytes4 methodId = bytes4(keccak256("echo()"));

        // 调用合约
        (bool success, bytes memory data) = fb.staticcall(abi.encodeWithSelector(methodId));
        if(success){
            return abi.decode(data, (string));
        } else {
            return "error";
        }
    }
}
```

我们先部署合约 Fallback，再使用 Fallback 的地址来部署 SolidityTest，调用 Fallback 方法 echo 方法，就会触发 Fallback 的 fallback 方法。
