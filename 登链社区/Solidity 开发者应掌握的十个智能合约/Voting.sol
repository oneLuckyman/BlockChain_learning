// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 区块链上的民主！投票合约使用户能够对重要事项进行投票，所有结果都被不可变地记录在区块链上。

// Voting Contract
contract Voting {
    address[] public voters;
    mapping(address => bool) public hasVoted;
    mapping(string => uint256) public votes;

    event Voted(address indexed voter, string option);

    function vote(string memory option) public {}

    // Additional function...
}