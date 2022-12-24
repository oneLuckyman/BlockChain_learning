// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    // 动态数组
    uint[] public arr = [1, 2, 3, 4];
    // 固定长度数组
    uint[4] public arrFixed = [1, 2, 3, 4];

    // 获得数组全部元素
    function getArr() external view returns(uint[] memory) {
        return arr;
    }

    // 固定长度数组操作
    function operatFixedArr() external {
        // 获得数组长度
        uint len = arrFixed.length; // len = 4
        // 获得第二个元素
        uint x = arrFixed[1];       // x = 2
        // 删除第二个元素，delete 只将元素设置为初值，并不改变数组长度
        delete arrFixed[1];         // [1, 0, 3, 4]
    }

    // 动态数组操作
    function operateDynamicArr() external {
        // 获得数组长度
        uint len = arr.length;      // len = 4
        // 追加一个元素
        arr.push(5);                // [1,2,3,4,5]
        // 弹出一个元素
        arr.pop();                  // [1,2,3,4]
        // 获得第二个元素
        uint x = arr[1];            // x = 2
        // 删除第二个元素，delete 只将元素设置为初值，并不改变数组长度
        delete arr[1];              // [1,0,3,4]
        // 删除第二个元素，并且长度减 1
        removeAt(1);                // [1,3,4]
    }

    // 删除数组元素，并且长度减 1
    function removeAt(uint i) public {
        require(i >= 0 && i < arr.length);
        for (uint k=i; k < arr.length - 1; k++){
            arr[k] = arr[k+1];
        }
        arr.pop();
    }
}