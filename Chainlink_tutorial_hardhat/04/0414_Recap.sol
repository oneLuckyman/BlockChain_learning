// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 除了可以导入本地文件，还以用一些固定协议导入 GitHub 等互联网上的其他文件
import "./0403-03_PriceConverter.sol";

error NotOwner();

contract FundMe {
    // 使用 Library 可以降低单个合约的复杂度，从而让合约集中于核心功能，增加可读性
    using PriceConverter for uint256;

    // 度量单位和单位转换
    // 被声明为 constant 的变量只能在声明时赋值一次，之后不能再更改
    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // immutable 也是一种常量，但与 constant 不一样，声明为 immutable 的变量可以在构造函数中更改一次
    address public immutable i_owner;

    // 构造函数可以在合约被部署后自动执行一次
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable{
        // 如何使用 require 对合约进行限制
        require(msg.value.getConversionRate() > MINIMUM_USD, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        /* starting index, ending index, step amount */
        // solidify 的关键特点之一就是可以使用循环结构，for 循环是其中一种
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array 
        // 使用 new 重置数组
        funders = new address[](0);
        // 一共有三种方式可以调用合约进行汇款，transfer，send，call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    // modifier 函数可以对其他函数进行修饰，扩展函数的功能
    modifier onlyOwner {
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }
    
    // receive 函数是一种特殊的函数，当使用合约但没有 call 合约的任何函数时，会自动执行这个函数
    receive() external payable {
        fund();
    }

    // fallback 函数也是一种特殊函数，当使用合约并不存在的函数时，也就是 call 发送了错误的请求时，会调用此函数
    // 或者 call 为空白，且没有 receive 函数时也会执行该函数
    fallback() external payable {
        fund();
    }
}    