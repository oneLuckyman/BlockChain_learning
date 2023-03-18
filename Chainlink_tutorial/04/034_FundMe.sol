// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./026_PriceConverter.sol";

// 为了解决 require 耗费更多 gas 的问题，可以自定义报错类型
error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender();
    }

    function fund() public payable{
        require(msg.value.getConversionRate() > MINIMUM_USD, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        /* starting index, ending index, step amount */
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array 
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner {
        // "Sender is not owner!" 这段字符串会单独进行存储，因此会耗费更多 gas
        // require(msg.sender == i_owner, "Sender is not owner!");
        // 通过以下判断语句可以让报错仅仅是调用代码，从而减少 gas 消耗
        // 但是现在主流的方法仍然是使用 require 语句，因为自定义错误类型还是个比较新的语言特性
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }
}