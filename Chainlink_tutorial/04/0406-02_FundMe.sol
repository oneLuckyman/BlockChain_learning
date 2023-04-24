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
        /* starting index, ending index, step amount */
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array 
        funders = new address[](0);
        // actually withdraw the funds

        // 如何从当前合约发送区块链原生货币，有三种方式
        // transfer
        // send 
        // call

        // transfer
        // msg.sender = address
        // payable(msg.sender) = payable address
        // 第一种：使用 transfer 直接发送货币给调用者
        // 这里的 msg.sender 是当前函数调用者的地址
        // this 则是指当前合约本身 
        // balance 指某个地址的全部余额
        // 只有 payable 类型的地址才可以接收区块链原生货币
        // transfer 的特点是，一旦超出其容许的 gas 上限，或发生其他中断语句的错误时，会直接报错并回退交易
        payable(msg.sender).transfer(address(this).balance); 

        // send
        // 第二种：send 与 transfer 很相似
        // 区别在于，send 语句若无法正常执行完毕，不会直接报错并回退交易，而是返回布尔值 false
        // 如果成功执行则会返回 true
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");

        // call
        // 第三种：使用 call() 发送交易
        // 在 call 的括号中可以填入任何想要调用的其他合约的函数的信息
        // 这里并不需要调用其他函数，所以就保持为空，call("")
        // 给 call 添加的附加信息在 call{}() 的花括号中，这里是 value: address(this).balance
        // 这和直接在 Remix 的界面上输入 value 然后点击函数按钮进行交易非常相似
        // call 有两个返回值
        // 第一个是是否成功执行语句，成功为 true，反之为 false
        // 第二个是 call 所调用的函数其自身的返回值，这里选择对第二个返回值留白，不进行存储
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
        // 这里最推荐的发送和接收原生货币的方式是使用 call 进行交易
    }
}