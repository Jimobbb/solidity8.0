// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 查看默认值

contract DefaultValues {
    bool public b; // false
    uint public u; // 0
    int public i; // 0
    address public a; // 0x0...0(四十个0)
    bytes32 public b32; // 0x0...0(64个0)
}