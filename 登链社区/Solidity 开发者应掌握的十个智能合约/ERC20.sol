// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 去中心化金融的基础，ERC-20 代币标准是每个 Solidity 开发者必须了解的。
// 它定义了一组规则，使得在以太坊网络上创建同质化代币成为可能。
// 无论你计划发行自己的加密货币还是参与 DeFi 生态系统，这个合约都是必不可少的。

// ERC-20 Token Contract
contract ERC20Token {
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 initiaSupply, string memory tokenName, string memory tokenSymbol) {
        totalSupply = initiaSupply * 10 ** uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        name = tokenName;
        symbol = tokenSymbol;
    }

    // Additional functions...
}