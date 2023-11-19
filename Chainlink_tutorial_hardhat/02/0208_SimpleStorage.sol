// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {

    uint256 public favoriteNumber;

    // 可以把 mapping 理解成是一个字典，创建一个 mapping
    mapping(string => uint256) public nameToFavoriteNumber;

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

    function addPerson(string memory _name, uint256 _favoriteNumber) public {   
        people.push(People(_favoriteNumber, _name));
        // 为 mapping 提供键和值
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}