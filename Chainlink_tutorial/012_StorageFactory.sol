// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./011_SimpleStorage.sol";

contract SotrageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simplestorage = new SimpleStorage();
        simpleStorageArray.push(simplestorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // 要想与任何合约互动，总是需要以下两者
        // Address
        // ABI - Application Binary Interface
        // 通过地址和接口访问和调用对应的合约以及合约的函数
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        simpleStorage.store(_simpleStorageNumber);
        // 上面两句与下面这一语句相同
        // simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}