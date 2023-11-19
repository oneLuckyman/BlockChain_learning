// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 导入 library 所在的文件
import "./0403-03_PriceConverter.sol";

contract FundMe {
    // 使用 using A for B 语句将对应的 library 导入
    // 下面的语句意为，将 PriceConverter 库附着到类型 uint256 上
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        // 现在可以对 msg.value 直接调用 getConversionRate 函数
        // 相当于 msg.value 作为 getConversionRate 的第一个参数输入到 getConversionRate 中
        require(msg.value.getConversionRate() > minimumUsd, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    // 现在 FundMe 合约已经只包含合约最需要的功能或者说函数，而单位转换这些功能放到了 PriceConverter library 中

    // function withdraw(){}
}