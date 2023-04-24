// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./0403-03_PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    constructor(){
        owner = msg.sender();
    }

    function fund() public payable{
        require(msg.value.getConversionRate() > minimumUsd, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    // 把 modifier 的函数名添加到函数的声明中
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

    // modifier 是一种修饰函数的函数，有点类似 python 中的装饰器，或者 Java 中的闭包
    modifier onlyOwner {
        require(msg.sender == owner, "Sender is not owner!");
        // 下划线表示被修饰的函数的全部内容，将 _ 放置于上面的语句后面表示先执行上面的语句，在执行被修饰函数，反之亦然
        _;
    }
}