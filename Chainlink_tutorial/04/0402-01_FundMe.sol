// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 此段来源于 Chainlink 的 github，用一种简单粗暴的方式提供接口的使用
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

    uint256 public minimumUsd = 50;

    function fund() public payable{
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        
        require(msg.value > minimumUsd, "Didn't send enough!");
    }

    function getPrice() public {
        // 为了获得价格信息，需要以下二者
        // ABI  需要得到用于调用获得信息的接口
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        // 该地址是 Chainlink 项目上给 goerli 测试网提供 ETH/USD 价格信息的合约地址
        // 换言之,正是从此合约存储的信息中找到并返回价格信息,为此还需要知道调用该合约的 ABI,调用接口方可获得信息
    }

    // 使用接口
    function getVersion() public view returns (uint256) {
        // 声明一个 priceFeed ,通过把地址输入进接口中，获得该地址对应合约的一系列信息
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
        // version() 函数返回当前合约的版本号信息
        // 价格信息可以通过调用 latestRoundData 获得，该函数返回一组数，其中第二个 (int256 answer) 就是 goerli 测试网上 ETH/USD 的价格信息
    }

    function getConversionRate() public {}

    // function withdraw(){}
}