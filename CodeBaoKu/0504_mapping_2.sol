// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LedgerBalance {
    mapping(address => uint) public balances;

    function updateBalance() public returns (uint) {
        // mapping 局部变量 ref 引用状态变量 balances
        mapping(address => uint) storage ref = balances;
        ref[msg.sender] = 3;
        return 0;
    }
}