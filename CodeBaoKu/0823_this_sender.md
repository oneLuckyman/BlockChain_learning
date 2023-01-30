# Solidity this 和 msg.sender 的用法

Solidity 中 this 代表合约对象本身，可以通过 address(this) 获取合约地址。合约地址与合约创建者地址、合约调用者地址并不相同。

Solidity 中 msg.sender 代表合约调用者地址。一个智能合约既可以被合约创建者调用，也可以被其它人调用。

合约创建者，即合约拥有者，也就是指合约部署者，它的地址可以在合约的 constructor() 中，通过 msg.sender 获得，因为合约在部署的时候会首先调用 constructor()。

## 范例

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    address public owner;

    event log(address);
    
    constructor() {
        owner = msg.sender;
        emit log(msg.sender);
        emit log(address(this));
    }
}
```

owner 被赋值为合约部署者的地址。

log(msg.sender) 在日志中输出了合约部署者的地址。

log(address(this)) 在日志中输出了合约地址。

查看合约在部署时的日志结果：

```solidity
[
    {
        "from": "0xE3Ca443c9fd7AF40A2B5a95d43207E763e56005F",
        "topic": "0x2c2ecbc2212ac38c2f9ec89aa5fcef7f532a5db24dbf7cad1f48bc82843b7428",
        "event": "log",
        "args": {
            // 合约部署者的地址
            "0": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
        }
    },
    {
        "from": "0xE3Ca443c9fd7AF40A2B5a95d43207E763e56005F",
        "topic": "0x2c2ecbc2212ac38c2f9ec89aa5fcef7f532a5db24dbf7cad1f48bc82843b7428",
        "event": "log",
        "args": {
            // 合约地址
            "0": "0xE3Ca443c9fd7AF40A2B5a95d43207E763e56005F"
        }
    }
]
```
