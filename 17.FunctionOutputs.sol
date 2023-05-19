// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 函数输出

contract FunctionOutputs {
    // 内部外部都可以调用——public
    function returnMany() public pure returns (uint, bool) {
        return (1, true);
    }

    function named() public pure returns (uint x, bool b) {
        // 隐式返回——因为返回定义的名称
        x = 1;
        b = true;
    }

    function destructingAssigments() public pure {
        (uint x, bool b) = returnMany();
        // (, bool _b) = returnMany(); // 不需要第一个参数，要留空位，减少gas
    }
}