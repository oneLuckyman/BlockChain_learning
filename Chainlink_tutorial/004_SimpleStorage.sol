// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    uint256 public favoriteNumber;

    // 结构体
    People public person = People({favoriteNumber: 2, name: "Patrick"});

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // array
    uint256[3] public favoriteNumberList;            // 固定大小数组
    People[] public people;                         // 动态数组

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // people.push(People(_favoriteNumber, _name));
        People memory newPerson = People(_favoriteNumber, _name);
        people.push(newPerson);
    }
}