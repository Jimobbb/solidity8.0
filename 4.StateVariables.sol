// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 状态变量
// 把一个状态写在区块链上，如果不写修改的方法，就会永远保存在区块链上
contract StateVariables {
    uint public myUint = 123; // 定义一个状态变量和初始值

    function foo() external pure {
        // 局部变量——调用foo函数后才会在虚拟机的内存中产生
        uint notStateVariables = 456;
    }
}