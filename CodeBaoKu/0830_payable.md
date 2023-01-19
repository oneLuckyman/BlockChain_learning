# Solidity 支付Eth payable 

使用 payable 标记的 Solidity 函数可以用于发送和接收 Eth。payable 意味着在调用这个函数的消息中可以附带 Eth。

使用 payable 标记的 Solidity 地址变量，允许发送和接收 Eth。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Payable {
    // owner 可用于收费 eth
    address payable public owner;

    constructor() {
        // msg.sender 默认不能收发 eth，需转换
        owner = payable(msg.sender);
    }

    function deposit() external payable{
    }
}
```

payable 地址变量可以通过 balance 属性，来查看余额。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Payable {
    function deposit() external payable{
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}
```
