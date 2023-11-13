// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 众筹已经被区块链技术革新。通过众筹合约，贡献者可以为一个共同的目标提供资金，当目标达成时，资金将释放给项目创建者。

// Crowdfunding Contract
contract Crowdfunding {
    address immutable public creator;
    uint256 public goal;
    uint256 public endTime;
    mapping(address => uint256) public contributions;

    event FundingReceived(address contributor, uint256 amount);
    event GoalReached(uint256 totalAmount);
    event FundsWithdrawn(address creator, uint256 amount);

    constructor(uint256 _goal, uint256 _duration) {
        creator = msg.sender;
        goal = _goal;
        endTime = block.timestamp + _duration;
    }

    function contribute() public payable {}
    function withdraw() public {}
}