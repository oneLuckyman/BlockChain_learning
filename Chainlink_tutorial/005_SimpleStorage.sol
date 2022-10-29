// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    // memory       表示该变量只在该函数调用时临时存在
    // storage      表示该变量即使在函数没有调用时也会存在
    // calldate     表示该变量只在函数调用时临时存在，并且是一个无法改变的常量

    // 还有三种数据存储形式：Stack, Code, Logs, 但是变量不能以这三种数据存储形式存在

    uint256 public favoriteNumber;      // 即使没有明确声明，此处的变量其实也是一个 storage 变量

    People public person = People({favoriteNumber: 2, name: "Patrick"});

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    uint256[3] public favoriteNumberList;
    People[] public people;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // 只能为 array struct mapping 类型指定数据位置，string 本质上是一种 array
    function addPerson(string memory _name, uint256 _favoriteNumber) public {   
        // Solidity 可以自动知道 uint256 类型的数据存放的位置，因此此处的 _favoriteNumber 不需要也不能声明 memory
        people.push(People(_favoriteNumber, _name));
    }
}