// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract funreturn {
    
    // 返回值可以有名字
    function returnTest() public view returns(uint mul){
        uint a = 10;
        return a;
    }

    // 可以直接为返回值赋值
    function returnTest2() public view returns(uint mul){
        mul = 10;
    }

    // 当给返回值赋值后，并且还有 return，以最后的 return 为准
    function returnTest3() public view returns(uint mul){
        uint a = 10;
        mul = 100;
        return a;
    }

    // 返回常量，自动匹配
    function returnTest4() public view returns(uint mul){
        uint a = 10;
        mul = 100;
        return 1;
    }

    // 函数可以有多个返回值，可以给多返回值赋值
    function returnTest5(uint a, uint b) public view returns(uint add, uint mul){
        add = a + b;
        mul = a * b;
    }

    // 函数有多个返回值，使用 return(param list) 返回
    function returnTest6(uint a, uint b) public view returns(uint add, uint mul){
        return(a+b,a*b);
    }

    // 交换变量的值
    function returnTest7(uint a, uint b) public view returns(uint a1, uint b1){
        return(b,a);
    }
}