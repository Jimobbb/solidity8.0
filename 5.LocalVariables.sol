// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract LocalVariables {
    // 定义三个状态变量
    uint public i;
    bool public b;
    address public myAddress;

    // 定义一个函数
    function foo() external {
        uint x = 123;
        bool f = false;
        // 假设添加了一些代码并改变了x和f的值
        x += 456;
        f = true;

        i = 123;
        b = true;
        myAddress = address(1);
    }
    // 最终结果：状态变量因为函数所以值被修改，而局部变量不会因为如此影响链上数据的变化
}