// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// 这里的版本要求和 011_SimpleStorage.sol 中的要求不一样，编译时需要挑选二者都兼容的版本
// 但必须存在一个二者都兼容的版本才行
// 这里需要指正一下，^0.8.0 表示只有在 0.8.* 版本中大于 0.8.0 版本才可以用，例如 0.9.0 就是不可以的

// 导入另一个文件，这等同于把另一个文件中的代码复制到这个文件
import "./011_SimpleStorage.sol";

contract SotrageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simplestorage = new SimpleStorage();
        simpleStorageArray.push(simplestorage);
    }
}