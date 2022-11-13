// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 可以通过 NPM 导入 github 上的合约
// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// 为了能完整演示，这里依然使用复制代码的方式，只需记住，下面一段代码等同于上面的 import 语句
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}

contract FundMe {

    uint256 public minimumUsd = 50 * 1e18;

    function fund() public payable{
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        
        require(getConversionRate(msg.value) > minimumUsd, "Didn't send enough!");
    }

    function getPrice() public view returns(uint256) {
        // ABI
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        // 一共有以下几种数据被返回回来
        // (uint80 roundID, int price, uint startedAt, uint timeStamp, uint80 answeredInRound) = priceFeed.latestRoundData();
        // 如果只需要获得 price，可以
        (,int256 price,,,) = priceFeed.latestRoundData();
        // ETH in terms of USD
        // AggregatorV3Interface 有一个 decimals() 函数，可以查看返回的整数有几位代表小数点后
        // 现在的例子是 8 位小数，即 1 ETH = 3000 USD，3000 被表示为
        // 300000000000 就是 3000.00000000 
        // 1 ETH = 1e18 wei，可以认为 msg.value 是具有18位小数 ETH 单位的值，因此该函数需要返回结果乘 10 次方
        return uint(price * 1e10);
    }

    // 使用接口获取版本信息
    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        // ethPrice 和 ethAmount 都有 1e18 所以二者相乘需要除以 1e18，否则就会变成 1e36
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    // function withdraw(){}
}