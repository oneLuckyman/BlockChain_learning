// SPDX-License-Identifier: MIT  
pragma solidity ^0.8.8;
// 第一个智能合约的总结
// 第一行：每一个 .sol 都应该包含这一行语句，它声明了该文件所使用的开源或非开源协议
// 第二行：指定了该文件所使用的 Solidity 版本，有以下几种语法：
            // pragma solidity 0.8.7;               表示只有0.8.7版本的 solidity 可以编译
            // pragma solidity ^0.8.7;              表示0.8.7以及以上版本的 solidity 可以编译
            // pragma solidity >=0.8.7 <0.9.0;      表示大于等于0.8.7小于0.9.0版本的 solidity 可以编译

// 创建并命名一个合约
contract SimpleStorage {
    // Solidity 语言有许多数据类型，一些基础的数据类型包括
    // bool, uint, int, address, string, bytes
    uint256 favoriteNumber;

    // 变量可以分为公有和私有，public private

    // 也可以利用结构体新建一种类型
    struct People{
        uint256 favoriteNumber;
        string name;
    }

    // Solidity 中也具有 array 类型
    People[] public people;

    // Solidity 中的 mapping 类型类似 dictionary 
    mapping(string => uint256) public nameTofavoriteNumber;

    // Solidity 中的函数，使用 function 来声明
    // 声明为 view 和 pure 的函数不修改合约和区块链的状态
    // 其中 view 函数可以访问合约中的其他数据，pure 函数不可以
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    // Solidity 中的一些数据类型由简单的数据类型组合而成，它们是
    // array    struct  mapping
    // 这些数据类型相比于基础数据类型消耗的计算量较大，因此必须指明数据的存储位置，有三种位置可以分配
    // storage  memory  calldata
    // storage 位置表明永久存储数据，合约中的所有函数都可以访问
    // memory 位置表明在函数中临时存储数据，函数执行完毕数据就会被抛弃，只能被其所处的函数访问
    // calldata 位置表明不可修改的临时存储数据，与 memory 类似但是不能被修改
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameTofavoriteNumber[_name] = _favoriteNumber;
    }
}