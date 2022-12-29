// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    function operations(string calldata val) pure external{
        // 使用 calldata 传递参数，省却复制成本
        internalFunc1(val);

        // 使用 memory 传递参数，需要进行复制
        internalFunc2(val);
    }

    function internalFunc1(string calldata val) internal pure {
        // ......
    }

    function internalFunc2(string memory val) internal pure {
        // ......
    }
}