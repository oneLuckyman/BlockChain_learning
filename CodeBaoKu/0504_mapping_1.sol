// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract LedgerBalance {
    mapping(address => uint) public balances;

    function updateBalance(uint newBalance) public {
        // 设置 mapping 的 key 和 value
        balances[msg.sender] = newBalance;
    }

    function get() public view returns(uint){
        // 通过 key 获取 mapping 的 value
        return balances[msg.sender];
    }
}

contract Updater {
    function updateBalance() public returns (uint) {
        LedgerBalance ledgerBalance = new LedgerBalance();
        ledgerBalance.updateBalance(10);
        return ledgerBalance.get();
    }
}