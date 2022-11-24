// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// solidity 中存在一些特殊函数，其中两个是 receive 和 fallback，之前使用过的 constructor 也是

contract FallbackExample {
    uint256 public result;

    // 每一次向合约发送交易，实际上都是在给合约发送 CALLDATA
    // CALLDATA 就是指定这次交易要调用合约的哪些数据
    // 通常来说这些数据指的就是合约中的某个函数，或者单纯发送 ETH
    // 当一次交易没有调用任何函数时，就会调用 receive() 函数，可以是单纯发送 ETH 也可是纯粹的没有调用任何数据也没有发送 ETH
    // 可以在 Remix 中测试，只有当 CALLDATA 留白时 result 才会执行修改为 1
    receive() external payable {
        result = 1;
    }

    // fallback() 函数和 receive() 有些类似，也是在特殊情况下自动调用的函数
    // 当 CALLDATA 发送错误值时，就会调用 fallback() 函数
    // 即，既没有留白，也没有指定调用合约中存在的函数，而是发送了错误的调用信息
    fallback() external payable {
        result = 2;
    }
}

// Explainer from: https://solidity-by-example.org/fallback/
// Ether is sent to contract      当出现没有调用合约已经存在的函数时
//      is msg.data empty?              msg.data 是否为空
//          /   \
//         yes  no
//         /     \
//    receive()?  fallback()    为空就判断是否存在 receive() 不为空就执行 fallback()
//     /   \
//   yes   no
//  /        \
//receive()  fallback()    如果存在 receive() 就执行 receive() 如果不存在 receive() 就执行 fallback() 如果连 fallback() 都没有就会报错