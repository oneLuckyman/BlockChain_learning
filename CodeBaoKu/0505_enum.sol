// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityTest {
    enum Status {
        None,
        Pending,
        Completed,
        Canceled
    }

    Status public status;

    // 获取状态
    function getStatus() external view returns(Status){
        return status;
    }

    // 设置状态
    function setStatus(Status _status) external{
        status = _status;
    }

    // 设置完成状态
    function setCompleted() external{
        status = Status.Completed;
    }
}