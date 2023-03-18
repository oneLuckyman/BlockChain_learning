// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./026_PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        require(msg.value.getConversionRate() > minimumUsd, "Didn't send enough!");
        funders.push(msg.sender);
        // 注意此处教程没有说明，但是实际上将下面这一行修改成了 += msg.value，显然这是更合理的
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public {
        /* starting index, ending index, step amount */
        // 与 C++ 中的 for 循环几乎一样
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
    }
}