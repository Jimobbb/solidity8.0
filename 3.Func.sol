// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 可以在remix里测试运行效果
contract FunctionIntro {
    // external——只能在外部读取的函数
    // pure——纯函数，函数不能读写，只能拥有局部变量，对链不能读写操作
    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }

    function sub(uint x, uint y) external pure returns (uint) {
        return x - y;
    }
}