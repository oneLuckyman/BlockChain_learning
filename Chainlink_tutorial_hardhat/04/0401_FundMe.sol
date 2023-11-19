// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {

    function fund() public payable{
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        
        // require 如果参数内第一个参数为 true 就继续执行
        // 如果为 false 就返回第二个参数输入的报错信息并将合约还原至函数运行前的状态以及返还未使用的 Gas
        // msg.value 调用对该合约发起的消息所附带的原生区块链货币，在以太坊中以 wei 为单位
        require(msg.value > 1e18, "Didn't send enough!");      // 1e18 = 1 * 10 ** 18 wei
    }

    // function withdraw(){}
}