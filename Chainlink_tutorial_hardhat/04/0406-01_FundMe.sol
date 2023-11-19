// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./0403-03_PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        require(msg.value.getConversionRate() > minimumUsd, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array 
        // 完全重置整个数组，括号里面的 0 指的是把数组完全重置为一个空数组
        // 如果是其他数字，则会初始化指定数字个元素
        // 这样会导致 push 的时候将从指定数字的位置的下一个位置开始添加
        funders = new address[](0);

    }
}