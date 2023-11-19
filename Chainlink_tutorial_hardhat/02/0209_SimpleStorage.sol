// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 最终用于测试部署的合约
contract SimpleStorage {

    // public 声明一个公有变量
    uint256 public favoriteNumber;

    // mapping 类型是一个键值映射
    mapping(string => uint256) public nameToFavoriteNumber;

    // 声明一种新的类型，这种类型是一种名为 People 的结构体
    People public person = People({favoriteNumber: 2, name: "Patrick"});

    // struct 声明一个结构体
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // array 数组，分为固定长度的数组和动态数组
    People[] public people;

    // function 声明一个函数
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // view 表明这个函数不修改合约状态，只读取合约状态
    // returns 表明函数返回值的类型
    function retrieve() public view returns(uint256) {      // 模拟 getter 函数
        return favoriteNumber;
    }

    // memory 表示该变量只在函数体内部临时存在
    function addPerson(string memory _name, uint256 _favoriteNumber) public {   
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}