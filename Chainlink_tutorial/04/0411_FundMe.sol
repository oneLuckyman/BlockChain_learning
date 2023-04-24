// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./0403-03_PriceConverter.sol";


// constant, immutable
// 二者节省 gas 的原理是一样的
// 它们不占用区块链存储槽，而是在部署时直接写入了虚拟机的字节码中

contract FundMe {
    using PriceConverter for uint256;

    // 如果一个变量，一旦合约书写完毕后就不再改变了，就可以使用 constant 关键字将其声明为一个常量
    // 这样做可以有效减少 gas 的消耗
    // 通常来说，constant 变量习惯使用全大写字母命名，以增加易读性
    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // owner 同样是一个确定下来就不会改变的值
    // 但是我们无法在声明时就确定 owner 应该是什么，只有当部署后 owner 才能确定下来
    // 这个时候不能使用 constant 关键字，因为无法通过静态输入确定这个值
    // 此时应该使用 immutable 关键字，它允许声明的变量在构造函数中改变一次，此后无法再进行更改
    // 与 constant 关键字一样 immutable 关键字也能够有效减少 gas 的使用
    // 可以使用 i_immutable 的形式增加可读性
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
        require(msg.sender == i_owner, "Sender is not owner!");
        _;
    }
}