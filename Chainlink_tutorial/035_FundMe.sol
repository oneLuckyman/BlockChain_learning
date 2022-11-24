// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./026_PriceConverter.sol";

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
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }

    // 如果有用户没有通过 fund 函数向本合约发送 ETH 或者不巧调用了错误的函数但是成功发送了 ETH 那么该如何记录下这个用户
    // 关于这两个特殊函数的解释，放在了 035_FallbackExample.sol 中
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}