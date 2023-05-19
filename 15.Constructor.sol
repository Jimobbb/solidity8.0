// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 构造函数——只能在合约开始的时候构造一次，之后再也不能被调用
// 用处：初始化变量

contract Constructor {
    address public owner;
    uint public x;

    // 运行合约时，可以输入_x的初始值
    constructor(uint _x) {
        owner = msg.sender;
        x = _x;
    }
} 