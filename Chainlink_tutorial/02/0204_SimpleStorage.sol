// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    uint256 public favoriteNumber;      // public 意味着编译器自动为变量创建了一个 getter 函数

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // view 表示这个函数只读取合约的状态，不会也不能修改任何合约的状态
    function retrieve() public view returns(uint256) {      // 模拟 getter 函数
        return favoriteNumber;
    }

    // pure 表示这个函数不仅不能修改合约状态，也不能读取合约状态，即这是一个不需要读取合约数据的函数
    function add() public pure returns(uint256) {
        return(1 + 1);
    }
}