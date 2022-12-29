// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    struct MyData {
        uint id;
        string value;
    }
    MyData[] public myData;

    constructor(){
        myData.push(MyData(1, "value1"));
        myData.push(MyData(2, "value2"));
    }

    function operations() external{
        // storage 存储位置
        MyData storage d = myData[0];

        // 修改状态变量 myData 的内容
        d.value = "new value";
    }
}