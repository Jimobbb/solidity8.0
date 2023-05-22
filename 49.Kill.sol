// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 自毁合约
// selfdestruct
// 强制删除合约 & 强制发送eth去任意地址

contract Kill {
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
}