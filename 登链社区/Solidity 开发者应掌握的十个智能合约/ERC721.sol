// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 非同质化代币（NFT）已经在数字世界中掀起了风暴。
// ERC-721 标准定义了创建这些独特、不可分割代币的规则。
// 无论你对数字艺术、收藏品还是游戏资产感兴趣，ERC-721 合约是你的首选。

// ERC-721 Token Contract
contract ERC721Token {
    string public name;
    string public symbol;

    mapping(uint256 => address) public ownerOf;
    mapping(address => uint256) public balance;
    mapping(uint256 => address) public approved;

    event Transfer(address indexed from, address indexed to, uint256 tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function transferFrom(address from, address to, uint256 tokenId) external {}
    function approve(address to, uint256 tokenId) external {}
}