// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 不可以被修改的变量，设置为常量——好处：节省gas费用
// 常量使用大写——习惯用法
contract Constants {
    // 21442 gas
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint public constant MY_UINT = 123;
}

contract Var {
    // 23553 gas
    address public MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
} 