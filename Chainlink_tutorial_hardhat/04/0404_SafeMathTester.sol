// SPDX-License-Identifier: MIT

/*
pragma solidity ^0.6.0;

contract SafeMathTester{
    uint8 public bigNumber = 255;  // unchecked
    
    // 在 solidity 0.6.0 及以下版本中，如果出现以下代码
    function add() public {
        bigNumber = bigNumber + 1;
    }
    // 就会出现数字溢出的现象，部署之后调用该函数会导致 bigNumber 变为 0
    // 这是因为 uint8 的最大值就是 255，继续增加就会溢出
}
*/

// solidity 有一个使用很广泛的库叫 safe math，在现在的 0.8.0 稳定版本下自动使用
pragma solidity ^0.8.0;

contract SafeMathTester{
    uint8 public bigNumber = 255;  // checked
    
    // 现在 bigNumber 是被检查过的，如果部署后调用 add 函数，虚拟机会返回错误
    function add() public {
        bigNumber = bigNumber + 1;
        // 也可以通过以下写法避免检查
        unchecked {bigNumber = bigNumber + 1;}
        // 被 unchecked 包括的代码不会被 safe math 审查
        // 这样的写法可以让合约消耗的 gas 数量更少
        // 所以，如果能够确定某一变量绝对不会溢出，就可以使用这样的写法
    }
}