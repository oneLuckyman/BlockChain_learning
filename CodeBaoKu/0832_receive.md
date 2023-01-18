# Solidity 接收函数 receive

solidity 接收函数 receive 没有参数、没有返回值。

solidity 向合约转账，发送 Eth，就会执行 receive 函数。

如果没有定义接收函数 receive，就会执行 fallback 函数。

## 向合约转账

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fallback {
    event eventFallback(string);

    fallback() external payable {
        emit eventFallback("fallback");
    }

    receive() external payable {
        emit eventFallback("receive");
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
"0": "receive"
}
}
]
```

我们调用合约 Fallback 的 getBalance 方法，查看合约地址的余额为 123 wei。

# receive 和 fallback 调用流程

向一个合约发送 Eth，何时调用 receive 或者 fallback 呢？下面是两者的调用流程。

```solidity
             发送 Eth
                |
            msg.data 是否为空
              /    \
            是      否
           /         \
 是否定义了receive   fallback
        /  \
       是   否
      /      \
 receive     fallback
```
