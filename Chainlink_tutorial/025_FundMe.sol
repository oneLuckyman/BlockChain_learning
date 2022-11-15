// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 这一部分的总结
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        // require 函数可以让所在函数被调用时进行检查，只有满足 require 的要求函数才会继续执行
        require(getConversionRate(msg.value) > minimumUsd, "Didn't send enough!");
        // msg.sender 和 msg.value 都是持续可用的全局变量
        // msg.value 是调用此函数的消息发送了多少区块链原生货币，在以太坊中是以 wei 为单位
        // msg.sender 是调用此函数的消息的发送者地址
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function getPrice() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // 在 solidity 中，通常不使用小数，因此总是会牵扯到单位问题
        return uint(price * 1e10);
    }

    function getVersion() public view returns (uint256) {
        // 需要调用合约时，总是需要 ABI 和 Address，该例中接口来自于从 github 中引入的合约
        // ABI
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        // 把 Address 输入到 ABI 中就可以调用合约的函数了
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    // function withdraw(){}
}