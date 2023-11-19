// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 总结
// 多个 .sol 文件的交互，导入文件
import "./0305_SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        // 通过 new 运算符新建一个对应的合约类
        SimpleStorage simplestorage = new SimpleStorage();
        simpleStorageArray.push(simplestorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // 要想与任何合约互动，总是需要 Address 访问指定合约，通过 ABI 调用合约的函数
        // Address
        // ABI - Application Binary Interface
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        simpleStorage.store(_simpleStorageNumber);
        // 上面两句与下面这一语句相同
        // simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    // 总是需要有返回指定数据的函数
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}

// 使用 is 声明一个合约继承自另一个合约
contract ExtraStorage is SimpleStorage {
    // 使用 override 可以重载父合约中的 virtual 函数
    // 父合约一定要声明成 virtual 的函数才能重载
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}